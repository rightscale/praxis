class Instance < Praxis::MediaType

  identifier 'application/json'
  
  attributes do 
    attribute :id, Integer
    attribute :href, String
    attribute :root_volume, Volume

    links do
      link :root_volume
      link :other_volume, Volume, using: :data_volume
    end
  end

  view :default do
    attribute :id
    attribute :root_volume
    attribute :links
  end

  view :link do
    attribute :id
    attribute :href
  end

end
