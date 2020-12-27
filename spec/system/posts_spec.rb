require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:post2) { create(:post, user: user2) }
  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe '編集のテスト' do
    context '自分の投稿の編集画面への遷移' do
      it '遷移できる' do
        visit edit_post_path(post)
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
    end
    context '他人の投稿の編集画面への遷移' do
      it '遷移できない' do
        visit edit_post_path(post2)
        expect(current_path).to eq('/posts')
      end
    end
    context '表示の確認' do
      before do
        visit edit_post_path(post)
      end
      it '投稿を編集すると表示される' do
        expect(page).to have_content('投稿を編集する')
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field, with: post.image
      end
      it 'コンテンツ編集フォームが表示される' do
        expect(page).to have_field, with: post.content
      end
      it '戻るリンクが表示される' do
        expect(page).to have_link, href: post_path
      end
    end
  end

  describe '一覧画面のテスト' do
    before do
      visit books_path
    end
    context '表示の確認' do
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(post.user)
        expect(page).to have_link '', href: user_path(post2.user)
      end
      it '自分と他人のコンテンツが表示される' do
        expect(page).to have_content post.content
        expect(page).to have_content post2.content
      end
    end
  end

  describe '詳細画面のテスト' do
    context '自分・他人共通の投稿詳細画面の表示を確認' do
      it 'ユーザー画像・名前のリンク先が正しい' do
        visit post_path(post)
        expect(page).to have_link post.user.name, href: user_path(post.user)
      end
      it '投稿の内容が表示される' do
        visit post_path(post)
        expect(page).to have_content post.content
      end
    end
    context '自分の投稿詳細画面の表示を確認' do
      it '投稿の編集リンクが表示される' do
        visit post_path post
        expect(page).to have_link '編集', href: edit_post_path(post)
      end
      it '投稿の削除リンクが表示される' do
        visit post_path post
        expect(page).to have_link '', href: post_path(post)
      end
    end
    context '他人の投稿詳細画面の表示を確認' do
      it '投稿の編集リンクが表示されない' do
        visit post_path(post2)
        expect(page).to have_no_link '編集', href: edit_post_path(post2)
      end
      it '投稿の削除リンクが表示されない' do
        visit post_path(post2)
        expect(page).to have_no_link '', href: post_path(post2)
      end
    end
  end
end