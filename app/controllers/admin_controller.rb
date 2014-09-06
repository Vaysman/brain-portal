class AdminController < ApplicationController	

	def index
		username = cookies[:auth_login]
		user_info = User.find_by username: username
		Access.is('settings.groups.delete', user_info.group_id)
			
	end

	###################################GROUPS#####################################
	def groups_create
		if (Access.is('settings.groups.create', @user_info.group_id))
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
		else
			redirect_to root_path
		end
	end

	def groups_edit
		if (Access.is('settings.groups.edit', @user_info.group_id))
			@action_title = 'groups_edit'
			if (params[:id])
				@actions = Pages.get_all
				@actions_active = GroupsToRoles.where(:group_id => params[:id]).all
				#raise @actions_active.inspect
				@actions_title = PagesActions.get_all
				@group = Group.find_by id: params[:id]
				if @group.nil?
					redirect_to url_for(:controller => :admin, :action => :groups_index)
				else
					if (params[:group])
						if (params[:group][:is_default].to_i == 1)
							@old_default_group = Group.find_by is_default: true
							if (@old_default_group && @old_default_group.id != @group.id)
								@old_default_group.update(:is_default => false)
							end
							@group.update(:title => params[:group][:title], :is_default => true)
						else
							@group.update(:title => params[:group][:title], :is_default => false)
						end
						redirect_to url_for(:controller => :admin, :action => :groups_index)
						if (params[:actions])
							GroupsToRoles.delete_all(:group_id => params[:id])
							params[:actions].each do |key, action|
								action.each do |keyt,act|
									@action = GroupsToRoles.new(:group_id => params[:id], :page_id => key, :action_id => keyt)
									@action.save
								end
							end
						end
					end
				end

			end
		else
			redirect_to root_path
		end
	end

	def groups_delete
		if (Access.is('settings.groups.delete', @user_info.group_id))
			if (params[:id])
				@group = Group.find_by id: params[:id]
				if @group.nil?
					redirect_to url_for(:controller => :admin, :action => :groups_index)
				else
					@group.destroy
					redirect_to url_for(:controller => :admin, :action => :groups_index)
				end
			end
		else
			redirect_to root_path
		end
	end

	def groups_index
		if (Access.is('settings.groups.index', @user_info.group_id))
			all.paginate(page: params[:page], per_page: 10)
		else
			redirect_to root_path
		end
		
	end

	private
	  def group_params
	    params.require(:group).permit(:title)
	  end
	####################################################################################
end
