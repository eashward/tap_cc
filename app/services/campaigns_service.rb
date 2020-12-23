class CampaignsService < BaseService
  include CampaignBuilder

  def client
    @client ||= ApiClient::CampaignsClient.new
  end

  def insert_campaigns
    campaigns = client.all.map.with_object([]) do |data, campaigns|
      campaigns << build_campaign(data: data)
      campaigns
    end
    rows = process_insertion(type: 'Campaign', records: campaigns)

    ids = rows.ids
    Rails.logger.info "#{ids.count} campaigns inserted into db"
    ids = Campaign.select(:id, :source_id).where(id: ids).pluck(:id, :source_id)
    insert_quotas(ids: ids)
  end

  def insert_quotas(ids:)
    quotas = ids.map.with_object([]) do |id, data|
      quotas = client.find(id: id.last)['campaign_quotas']
      quotas.map do |q|
        data << build_quota(data: q, campaign_id: id.first)
      end
    end

    rows = process_insertion(type: 'CampaignQuota', records: quotas, recursive: true)

    Rails.logger.info "#{rows.ids.count} campaign_quotas inserted into db"
    rows
  end

  def process_insertion(type:, records:, recursive: false)
    rows = Object
               .const_get(type)
               .import(
                   records,
                   returning: :source_id,
                   recursive: recursive,
                   batch_size: 1000
               )

    failed_instances = rows.failed_instances
    handle_failure_inserts(failed_rows: rows.failed_instances) if failed_instances.size > 1
    rows
  end

  def handle_failure_inserts(failed_rows:)
    Rails.logger.error "#{failed_rows.inspect} failed to insert"
    # enqueue them using a background processor to try fetching the record form remote
    # and try inserting again
  end


  def ordered_campaigns
    Campaign.includes(campaign_quotas: :campaign_qualifications)
        .order('campaign_quota.campaign_qualifications_count')
  end
end