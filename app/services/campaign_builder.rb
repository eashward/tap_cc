module CampaignBuilder
  def build_campaign(data:)
    attrs = {
        source_id: data['id'],
        length_of_interview: data['length_of_interview'],
        cpi: data['cpi'],
        name: data['name']
    }
    Campaign.new(attrs)
  end

  def build_quota(data:, campaign_id:)
    qualifications = data['campaign_qualifications']
    quota_attrs = {
        name: data['name'],
        campaign_id: campaign_id,
        campaign_qualifications_count: qualifications.count
    }
    qual_attrs = fetch_qual_attrs(qualifications: qualifications)

    quotas = CampaignQuota.new(quota_attrs)
    quotas.campaign_qualifications.build(qual_attrs)
    quotas
  end

  def fetch_qual_attrs(qualifications:)
    qualifications.map do |qual|
      {
        question_id: qual['question_id'],
        pre_codes: qual['pre_codes'].join(',')
     }
    end
  end
end