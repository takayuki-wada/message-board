class Message < ActiveRecord::Base
	# バリデーションの実装(データの整合性チェック)
	# 名前は、必須入力で20文字以内
	validates :name, length: { maximum: 20 }, presence: true
	# 内容は、必須入力で2文字以上30文字以内
	validates :body, length: { minimum: 2, maximum: 30 }, presence: true
	# 年齢は、0以上150以下の数字だけとする
	validates :age, numericality: {
		only_integer: true, greater_than: 0, less_than: 150
	}
end
