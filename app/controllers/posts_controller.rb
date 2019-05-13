class PostsController < ApplicationController
  def index
    # Post.allにorderメソッドを用いて、新しい投稿が上から順に表示されるようにしてください
    @posts = Post.all.order(created_at: :desc)
  end
  
  def show
    @post = Post.find_by(id: params[:id])
  end
  
  def new
    # newメソッドを用いて、Postクラスのインスタンスを作成し、変数@postに代入してください
    @post = Post.new(content: params[:content])
    render("/posts/new")
  end
  
  def create
    @post = Post.new(content: params[:content])
    # 保存に成功した場合は投稿一覧ページ、保存に失敗した場合は新規投稿ページが表示されるようにif-else文を追加してください
    if @post.save
      # 変数flash[:notice]に、指定されたメッセージを代入してください
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      # 変数flash[:notice]に指定されたメッセージを代入してください
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      redirect_to("/posts/#{@post.id}/edit")
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    # 変数flash[:notice]に、指定されたメッセージを代入してください
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
end
