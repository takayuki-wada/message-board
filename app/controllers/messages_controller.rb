class MessagesController < ApplicationController
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

	private
  # 許可するパラメータをカプセル化する
  # 許可する属性をメッセージ毎にチェックするようこのメソッドを特殊化
  def message_params
  	# paramsがmessageというKeyが存在するか検証し、params[:message]のうち、
  	# :nameおよび:bodyの値のみ受取るようにフィルタリング
  	params.require(:message).permit(:name, :body)
  end
end
