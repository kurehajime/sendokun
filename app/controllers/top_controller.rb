class TopController < ApplicationController
    def index
        return_image(:error)
    end

    def return_image(file_name)
        filepath = Rails.root.join('app', 'assets','images', "#{file_name}.svg")
        stat = File::stat(filepath)
        send_file(filepath, :filename => "#{file_name}.svg", :length => stat.size,:disposition => "inline")
    end

    def get_params
        params.permit(:user,:repo,:path,:yyyymmdd)
    end
end
