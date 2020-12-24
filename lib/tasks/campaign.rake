namespace :campaign do
    task insert: :environment do
      p 'Prcoessing task'
      CampaignsService.new.insert_campaigns
      p 'Import finished'
    end
end