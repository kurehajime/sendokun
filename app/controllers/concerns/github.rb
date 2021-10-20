require 'json'
require 'net/https'
require "uri"
module Github
    extend ActiveSupport::Concern
    
    def get_file_modify_date(user,repo,path)        
        uri = URI("https://api.github.com/repos/#{user}/#{repo}/commits?path=#{path}")
        get_modify_date(uri)
    end

    def get_repo_modify_date(user,repo)        
        uri = URI("https://api.github.com/repos/#{user}/#{repo}/commits")
        get_modify_date(uri)
    end

    private 

    def get_modify_date(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Get.new(uri)
        res = http.request(req)
        res_data=JSON.parse(res.body)
        if res_data.count>0 then
            if res_data[0] && res_data[0]["commit"] && res_data[0]["commit"]["committer"] && res_data[0]["commit"]["committer"]["date"] then
                Date.parse(res_data[0]["commit"]["committer"]["date"])
            end
        end 
    end

end