class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :length_of_interview, :cpi, :name

  has_many :campaign_quotas, serializer: CampaignQuotaSerializer
end