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
      expect(task.errors).to be_empty
    end

    # タイトルがなければ無効な状態であること
    it 'is invalid without a title' do
      task_without_title = FactoryBot.build(:task, title: nil)
      expect(task_without_title).to be_invalid
      expect(task_without_title.errors[:title]).to include("can't be blank")
    end

    # ステータスがなければ無効な状態であること
    it 'is invalid without a status' do
      task_without_status = FactoryBot.build(:task, status: nil)
      expect(task_without_status).to be_invalid
      expect(task_without_status.errors[:status]).to include("can't be blank")
    end

    # 重複したタイトルは無効であること
    it 'is invalid with a duplicate title' do
      task = FactoryBot.create(:task)
      task_with_duplicate_title = FactoryBot.build(:task, title: task.title)
      expect(task_with_duplicate_title).to be_invalid
      expect(task_with_duplicate_title.errors[:title]).to include("has already been taken")
    end

    # 別名のタイトルであれば有効であること
    it 'is valid with a another title' do
      task = FactoryBot.create(:task)
      task_with_another_title = FactoryBot.create(:task, title: 'test_title02')
      expect(task_with_another_title).to be_valid
      expect(task_with_another_title.errors[:title]).to be_empty
    end
  end
end
