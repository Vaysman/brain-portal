class AdminController < ApplicationController	

	def index
		raise  PagesActions.get_id_by_alias('delete').inspect
	end

	###################################GROUPS#####################################
	def groups_create
		@action_title = 'groups_create'
		if (params[:group])
			@group = Group.new(group_params)
			if params[:group][:is_default]
				@old_default_group = Group.find_by is_default: true
				if @old_default_group
					@old_default_group.update(:is_default => false)
				end
				@group.is_default = true
			end
				if @group.save
					redirect_to url_for(:controller => :admin, :action => :group_index)
				end
		else
			@group = Group.new
		end
	end

	def groups_edit
		@action_title = 'groups_edit'
		if (params[:id])
			@actions = Pages.get_all
			@actions_active = GroupsToRoles.find_by group_id: params[:id]
			@actions_title = PagesActions.get_all
			@group = Group.find_by id: params[:id]
			if @group.nil?
				redirect_to url_for(:controller => :admin, :action => :groups_index)
			else
				if (params[:group])
					if params[:group][:is_default]
						@old_default_group = Group.find_by is_default: true
						if @old_default_group
							@old_default_group.update(:is_default => false)
						end
						@group.update(:title => params[:group][:title], :is_default => true)
					end
					@group.update(:title => params[:group][:title])
					redirect_to url_for(:controller => :admin, :action => :groups_index)
				end
			end

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
