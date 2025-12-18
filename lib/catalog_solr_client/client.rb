module CatalogSolrClient
  class Client
    def initialize
      @conn = Faraday.new(
        url: CatalogSolrClient.configuration.solr_url
      ) do |f|
        f.request :json
        #  f.request :retry, {max: 1, retry_statuses: [500]}
        f.response :json
      end
      @path_prefix = "/solr/#{CatalogSolrClient.configuration.core}"
    end

    def get_bibs(bib_ids:, core: "biblio")
      query = {
        q: "id:(#{bib_ids.join(" OR ")})",
        rows: bib_ids.size,
        fl: ["id", "callnumber", "title_display", "main_author_display",
          "publisher_display", "series_statement", "edition", "isbn", "issn",
          "oclc", "display_date"].join(",")
      }

      @conn.public_send(:get, "#{@path_prefix}/select", query)
    end
  end
end
