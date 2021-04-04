require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    before do
      #ユーザーを作成
      user = FactoryBot.create(:user)
    end
    # タイトル、ステータスがあれば有効な状態であること
    it 'is valid with a title, status' do
      task = FactoryBot.build(:task)
      expect(task).to be_valid
    end

    # タイトルがなければ無効な状態であること
    it 'is invalid without a title' do
      task = FactoryBot.build(:task, title: nil)
      task.valid?
      expect(task.errors[:title]).to include("can't be blank")
    end

    # ステータスがなければ無効な状態であること
    it 'is invalid without a status' do
      task = FactoryBot.build(:task, status: nil)
      task.valid?
      expect(task.errors[:status]).to include("can't be blank")
    end

    # 重複したタイトルは無効であること
    it 'is invalid with a duplicate title' do
      task1 = FactoryBot.create(:task)
      task2 = FactoryBot.build(:task)
      task2.valid?
      expect(task2.errors[:title]).to include("has already been taken")
    end

    # 別名のタイトルであれば有効であること
    it 'is valid with a another title' do
      task1 = FactoryBot.create(:task)
      task2 = FactoryBot.create(:task, title: 'test_title02')
      expect(task2).to be_valid
    end
  end
end
