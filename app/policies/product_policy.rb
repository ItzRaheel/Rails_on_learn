class ProductPolicy < ApplicationPolicy

  class Scope < Scope

  
    def resolve
      return scope.none unless user

      if user.admin? 
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
    
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  
  def about?
    true
  end
  def create?
    user.present?
  end
  def edit? 
    user.admin? || record.user_id == user.id
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end
  def update?
    edit?
  end

  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
end
