require 'csv'
namespace :db do
  task geo: :environment do
    if Country.all.size == 0
      filename = File.expand_path(File.join(Rails.root, 'data', "countries.csv"))
      CSV.foreach(filename, :headers => true) do |row|
        Country.create!(row.to_hash)
      end
      puts "Geos loaded"
    end
  end
end