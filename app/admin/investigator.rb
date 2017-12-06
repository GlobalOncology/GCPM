ActiveAdmin.register Investigator do
  extend Featurable

  menu parent: "Entities"

  permit_params :name, :email, :website, :user_id, :is_approved

  filter :name
  filter :position_title

  member_action :approve, method: :patch do
    if resource.update(is_approved: true)
      UserMailer.user_relation_email(resource.user.name, resource.user.email, resource.name, 'approved', 'Investigator').deliver_later
      redirect_back fallback_location: admin_root_path, notice: 'The relation have been approved.'
    end
  end

  member_action :unapprove, method: :patch do
    if resource.update(is_approved: false)
      UserMailer.user_relation_email(resource.user.name, resource.user.email, resource.name, 'unapproved', 'Investigator').deliver_later
      redirect_back fallback_location: admin_root_path, notice: 'The relation have been unapproved.'
    end
  end

  member_action :delete_relation, method: :patch do
    UserMailer.user_relation_email(resource.user.name, resource.user.email, resource.name, 'removed', 'Investigator').deliver_later
    if resource.update(user_id: nil)
      redirect_back fallback_location: admin_root_path, notice: 'The relation have been removed.'
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :website
    actions do |obj|
      if obj.featured?
        link_to("Unfeature", unfeature_admin_investigator_path(obj))
      else
        link_to("Feature", feature_admin_investigator_path(obj))
      end
    end
  end

  form do |f|
    # so we can only get users that don't already have an associated investigator
    investigatorUsers = Investigator.where.not(user_id: nil).pluck(:user_id)
    # if the investigator being edited already has an assigned user
    if f.object.user.present? && f.object.user.id
      # the user should be in the investigatorUsers, so we need to fix that
      idPos = investigatorUsers.index(f.object.user.id);
      # hopefully we know where to remove the user's ID from now
      if (idPos != nil)
        investigatorUsers.delete_at(idPos);
      end
    end
    # get the users for the dropdown
    users = User.where.not(id: investigatorUsers).order(:name).map{ |u| [u.name, u.id] }
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :email
      f.input :user, as: :select, collection: users
      f.input :website
    end
    f.actions
  end

end
