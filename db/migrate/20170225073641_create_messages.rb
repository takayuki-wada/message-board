class CreateMessages < ActiveRecord::Migration
  def change
  	# messagesテーブルを作成
    create_table :messages do |t|
    	# nameというstringカラムとbodyというstringカラムの作成
      t.string :name
      t.string :body
      # 主キーは、id(Active Recordモデルにおけるデフォルトの主キー)という名前で暗黙に追加

			# timestampsマクロは、create_at と updated_at という2つのカラムを追加
			# create_atとupdate_atが存在する場合、Active Recordによって自動的に管理される
			# null:false のオプションは、データを保存する際に日時がnullにならないようにする
      t.timestamps null: false
    end
  end
end
