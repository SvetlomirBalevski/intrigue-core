module Intrigue
module Task
class SearchZetalytics < BaseTask

  def self.metadata
    {
      :name => "search_Zetalytics",
      :pretty_name => "Search Mnemonic",
      :authors => ["Anas Ben Salah"],
      :description => "This task offers passive DNS data by querying passive DNS data collected in Zetalytics.",
      :references => [],
      :type => "discovery",
      :passive => true,
      :allowed_types => ["Domain", "IpAddress"],
      :example_entities => [
        {"type" => "Domain", "details" => {"name" => "intrigue.io"}}
      ],
      :allowed_options => [
        {:name => "limit", :regex => "integer", :default => 0 }
      ],
      :created_types => ["DnsRecord", "IpAddress", "EmailAddress"]
    }
  end

  ## Default method, subclasses must override this
  def run
    super

    entity_name = _get_entity_name
    entity_type = _get_entity_type_string


    if entity_type =="Domain"
      data = SearchZetalytics.search_cname2qname (cname, key)
    # check if the resultset exceeds server resource constraints
      if data == nil
        _log_error("No avaible data !")
        #return
      else
        data["results"].each do |e|
          puts e["qname"]
        end
      end
    end

    else
      _log_error "Unsupported entity type"
    end #end if

   #end run

end
end
end
