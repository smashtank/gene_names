require 'net/http'
require 'uri'
require 'json'

module GeneNames
  class HTTP
    class InvalidResponse < StandardError; end;
    def self.fetch(value, type)
      do_request('/' + ['',:fetch, type, value].collect(&:to_s).join('/'))['response']['docs'].collect{|doc| GeneNames::Record.new(doc)}
    end

    def self.info
      do_request('/info')
    end

    def self.search
      #TODO
    end

    def self.searchable_fields=(*fields)
      @searchable_fields = fields
    end

    def self.searchable_fields
      return @search_fields || load_searchable_fields
    end

    def self.stored_fields=(*fields)
      @searchable_fields = fields
    end

    def self.stored_fields
      return @stored_fields || load_stored_fields
    end

    private

    def self.load_searchable_fields
      self.searchable_fields = self.info['searchableFields']
    end

    def self.load_stored_fields
      self.searchable_fields = self.info['storedFields']
    end

    def self.do_request(path, response_type = :json)
      http = build_http
      response = get_response(http, path, response_type)
      return parse_response(response)
    end

    def self.build_http
      url = URI.parse(GeneNames::SERVER)
      Net::HTTP.new(url.host, url.port)
    end

    def self.get_response(http, path, response_type)
      response = http.request(self.build_request(path, response_type))
      raise InvalidResponse, "Invalid response: #{response.code}" unless response.code == '200'
      return response
    end

    def self.build_request(path, response_type)
      Net::HTTP::Get.new(path, {'Accept' => accept_for_type(response_type)})
    end

    def self.parse_response(response)
      return case response.content_type
      when 'application/json'
        JSON.parse(response.body)
      when 'text/xml'
        #TODO
      else
        raise "Unknown content type: '#{response.content_type.to_s}'"
      end
    end

    def self.accept_for_type(response_type)
      case response_type
      when :json, 'json'
        'application/json'
      when :xml, xml
        'text/xml'
      else
        raise "Unknown response type: '#{response_type.to_s}'"
      end
    end
  end
end
