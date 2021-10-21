class TopController < ApplicationController
    include Github

    def index
        file_modify_date , doc_modify_date = get_file_and_doc_modify_date()
        if file_modify_date && doc_modify_date then
            if file_modify_date <= doc_modify_date  then
                return_image(:fresh)
            else
                return_image(:stale)
            end
        else
            return_image(:error)
        end
    end

private

    def get_file_and_doc_modify_date
        unless params[:user] && params[:repo] && params[:yyyymmdd] then
            return nil,nil
        end

        begin
            doc_modify_date = Date.parse(params[:yyyymmdd]) 
        rescue ArgumentError => e
            return nil,nil
        end

        file_modify_date = get_file_modify_date(params[:user],params[:repo],params[:path])

        unless file_modify_date && doc_modify_date then
            return nil,nil
        end 

        return file_modify_date,doc_modify_date
    end

    def return_image(file_name)
        filepath = Rails.root.join('app', 'assets','images', "#{file_name}.svg")
        stat = File::stat(filepath)
        send_file(filepath, :filename => "#{file_name}.svg", :length => stat.size,:disposition => "inline")
    end
end
