class CampaignQuotaSerializer < ActiveModel::Serializer
  attributes :id, :name, :campaign_qualifications_count
  has_many :campaign_qualifications, serializer: CampaignQualificationSerializer
end