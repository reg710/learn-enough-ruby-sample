class ApplicationController < ActionController::Base
    # By including the helper at this level, all controllers will have access to it
    include SessionsHelper
    def hello
        render html: "hello, world!"
    end
end
