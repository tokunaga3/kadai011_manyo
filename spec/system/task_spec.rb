require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context 'タスクが終了期限の降順に並んでいる場合' do
      before do
        Task.create!(id: 1,name: 'test1',content: 'test1',deadline: "2021-01-01T15:15")
        Task.create!(id: 2,name: 'test2', content: 'test2',deadline: "2021-01-31T15:15")
     end
      it '一覧画面で終了期限でソートするを押すと終了期限が遠いものが一番上に表示される' do
        visit root_path
        click_on '終了期限でソートする'
        task_list = all(".task_name")
        # binding.irb
        # ここに実装する
        expect(task_list[0]).to have_content 'test2'
        expect(task_list[1]).to have_content 'test1'
      end
    end
  end

end
