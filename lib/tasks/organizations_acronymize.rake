require 'csv'
namespace :organizations do
  desc "Imports a CSV file and create acronyms for organizations"
  task acronymize: :environment do
    file = 'data/acronyms.csv'
    CSV.foreach(file, :headers => true) do |row|
      org = Organization.find_by(grid_id: row['grid_id'])
      if org
        org.acronym = row['acronym']
        org.save!
      end
    end
    puts "Acronyms created"
  end
end
