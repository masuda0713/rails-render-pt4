class Ability
  include CanCan::Ability # CanCanCanの機能を読み込む

  # ユーザーがログインしている場合に呼び出される
  def initialize(user)
    user ||= User.new # 未ログインの場合（ゲストユーザー）

    if user.has_role?(:admin) # ユーザーが管理者の場合
      can :manage, :all # 管理者は全ての操作が可能

    elsif user.has_role?(:editor) # ユーザーが編集者の場合
      can :read, :all # 全てのデータを閲覧可能
      #can :manage, Recipe # 記事を作成・編集・削除できる。Recipeクラスがないため一時的にコメントアウト
      
    elsif user.has_role?(:user) # ユーザーが一般ユーザーの場合
      can :read, User, id: user.id # 自分のユーザー情報の閲覧のみ可能
      #can :read, Recipe # 記事の閲覧のみ可能。Recipeクラスがないため一時的にコメントアウト

    elsif user.has_role?(:viewer) # ユーザーが閲覧者の場合
      #can :read, Recipe # 記事の閲覧のみ可能。Recipeクラスがないため一時的にコメントアウト
    end
  end
end

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

  
