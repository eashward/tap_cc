# frozen_string_literal: true

class Api::CampaignsController < Api::BaseController
  def ordered_campaigns
    @res = CampaignsService.new.ordered_campaigns
    render json: @res, each_serializer: CampaignSerializer, include: "*.*"
  end
end
