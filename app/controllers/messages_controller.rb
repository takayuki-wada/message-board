class MessagesController < ApplicationController
	# set_messageメソッドは、editおよびupdate、destroyアクションの前に実行する(フィルタ機能)
	before_action :set_message, only: [:edit, :update, :destroy]

	# binding.pry

  # フォームを表示するアクションの定義
  def index
  	# Viewのform_forに渡すことでフォームが動作する
  	@message = Message.new
  	# Messageをすべて取得する
		@messages = Message.all
  end

  # パラメータにmessageキーがあれば成功
  # messageキーがなければ、ApplicationController:Baseにキャッチされ
  # 400 Bad Requestを返す
  def create
		@message = Message.new(message_params)
		# バリデーションで保存できなかった場合の処理がないためコメント化
		# @message.save
		# redirect_to root_path, notice: 'メッセージを保存しました'

		# バリデーションで処理に失敗した場合、再度入力を促す対応
		if @message.save
			# ビューヘルパを使用したリダイレクト
			# redirect_to root_path, notice: 'メッセージを保存しました'
			# flash[:notice] = "メッセージを保存しました"
			redirect_to root_path, notice: 'メッセージを保存しました'
		else
			# メッセージが保存できなかった処理
			@messages = Message.all
			# 同一リクエスト内でのみメッセージを出力
			flash.now[:alert] = "メッセージの保存に失敗しました"
			# コントローラ内のindexアクションに対応するViewを表示
			render "index"
		end
  end

	def edit
		# 編集画面に来た時に呼ばれるメソッド(アクション)
		# 但し、before_actionで定義した通り、最初にset_messageメソッドで処理が開始する
	end

	def update
		# set_messageメソッドでセットされたインスタンス変数を用いて更新処理を行う
		if @message.update(message_params)
			# 保存に成功した場合は、トップページへリダイレクト
			redirect_to root_path, notice: 'メッセージを編集しました'
		else
			# 保存に失敗した場合は、編集画面へ戻す(/views/messages/edit.html.erbを呼出す)
			render 'edit'
		end
	end

	def destroy
		# インスタンス変数に格納されたデータを削除
		@message.destroy
		# トップ画面への遷移とデータを削除したメッセージを出力
		redirect_to root_path, notice: 'メッセージを削除しました'
	end

	private
  # 許可するパラメータをカプセル化する
  # 許可する属性をメッセージ毎にチェックするようこのメソッドを特殊化
  def message_params
  	# paramsがmessageというKeyが存在するか検証し、params[:message]のうち、
  	# :nameおよび:bodyの値のみ受取るようにフィルタリング
  	params.require(:message).permit(:name, :body)
  end

  def set_message
  	# 編集しようとする投稿の内容を@messageにセットし、edit.html.erbをレンダリング
  	@message = Message.find(params[:id])
  end
end
