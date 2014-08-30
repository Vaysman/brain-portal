class AdminController < ApplicationController	

	def index
	end

	###################################GROUPS#####################################
	def groups_create
		@action_title = 'groups_create'
		if (params['group'])
			@group = Group.new(group_params)
			if @group.save
				redirect_to url_for(:controller => :admin, :action => :group_index)
			else

			end

		else
			@group = Group.new
		end
	end

	def groups_edit
		@action_title = 'groups_edit'
		if (params[:id])
			@group = Group.find_by id: params[:id]
			if @group.nil?
				redirect_to url_for(:controller => :admin, :action => :groups_index)
			else
				if (params['group'])
					@group.update(group_params)
					redirect_to url_for(:controller => :admin, :action => :groups_index)
				else

				end
			end

		else
		end
	end

	def groups_delete
		if (params[:id])
			@group = Group.find_by id: params[:id]
			if @group.nil?
				redirect_to url_for(:controller => :admin, :action => :groups_index)
			else
				@group.destroy
				redirect_to url_for(:controller => :admin, :action => :groups_index)
			end
		else
		end
	end

	def groups_index
		@groups = Group.all.paginate(page: params[:page], per_page: 10)
		
	end

	private
	  def group_params
	    params.require(:group).permit(:title)
	  end
	####################################################################################
end
