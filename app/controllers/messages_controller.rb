class MessagesController < ApplicationController
  # フォームを表示するアクションの定義
  def index
  	@message = Message.new
  	# Messageをすべて取得
		@messages = Message.all
  end

  # パラメータにmessageキーがあれば成功
  # messageキーがなければ、ApplicationController:Baseにキャッチされ
  # 400 Bad Requestを返す
  def create
		@message = Message.new(message_params)
		@message.save
		redirect_to root_path, notice: 'メッセージを保存しました'

  end

	private
  # 許可するパラメータをカプセル化する
  # 許可する属性をメッセージ毎にちぇっくするようこのメソッドを特殊化
  def message_params
  	# paramsがmessageというKeyが存在するか検証し、params[:message]のうち、
  	# :nameおよび:bodyの値のみ受取るようにフィルタリング
  	params.require(:message).permit(:name, :baody)
  end
end
