class HomesController < ApplicationController
    def top
    end
    def user_login
        if @current_user
            redirect_to users_path
        end
    end
end
