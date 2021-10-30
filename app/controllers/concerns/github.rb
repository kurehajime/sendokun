require 'json'
require 'net/https'
require "uri"
module Github
    extend ActiveSupport::Concern
    
    def get_file_modify_date(user,repo,branch,path)  
        res_data = get_commits(user,repo,branch,path)
        if res_data.count>0 then
            if res_data[0] && res_data[0]["commit"] && res_data[0]["commit"]["committer"] && res_data[0]["commit"]["committer"]["date"] then
                Date.parse(res_data[0]["commit"]["committer"]["date"])
            end
        end 
    end

    private 

    def get_commits(user,repo,branch,path)
        uri = URI("https://api.github.com/repos/#{user}/#{repo}/commits")
        uri.query = {
            path:path,
            sha:branch,
        }.to_param
        
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Get.new(uri)
        res = http.request(req)
        res_data=JSON.parse(res.body)
    end

end