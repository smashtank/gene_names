module GeneNames
  class Record
    GeneNames::HTTP.stored_fields.each do |f|
      attr_accessor f.to_sym rescue nil
    end

    def initialize(params = {})
      params.map{|k,v| self.send(k + '=', v)}
    end

    def self.find_all(value, type = :symbol)
      GeneNames::HTTP.fetch(value, type)
    end

    def chromosome
      self.location.gsub(/^(\d+).*$/, '\1')
    end
  end
end