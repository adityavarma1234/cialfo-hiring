class CollegesController < ApplicationController
	def index
		@colleges = College.paginate(page: params[:page], per_page: 10)
		#@colleges = Array(@colleges)
		#@colleges = @colleges.paginate(:page => params[:page])
	end
end
