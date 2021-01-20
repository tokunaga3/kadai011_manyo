require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        # ここに内容を記載する
        task = Task.new(content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        # ここに内容を記載する
        task = Task.new(name: 'テスト通過', content: 'テスト通過')
        expect(task).to be_valid
      end
    end
  end
  describe 'step3' do
    context 'scopeのテスト' do
      before do
         FactoryBot.create(:task,name: 'test1',content: 'test1',status: "未着手")
         FactoryBot.create(:task,name: 'test2', content: 'test2',status: "着手中")
         FactoryBot.create(:task,name: 'test3', content: 'test3',status: "完了")
      end

      it 'scopeメソッドでタイトルのあいまい検索ができる' do
        test_task = Task.name_sarch(Task.all[1][:name])
        expect(test_task[0]).to eq Task.all[1]
      end

      it 'scopeメソッドでステータス検索ができる' do
        test_task = Task.status_sarch(Task.all[1][:status])
        expect(test_task[0]).to eq Task.all[1]
      end

      it 'scopeメソッドでタイトルのあいまい検索、かつステータスの両方が検索できる' do
        test_task = Task.status_sarch(Task.all[1][:status]).name_sarch(Task.all[1][:name])
        expect(test_task[0]).to eq Task.all[1]
      end
    end
  end
end
