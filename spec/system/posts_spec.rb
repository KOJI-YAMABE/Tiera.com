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
      it 'Booksと表示される' do
        expect(page).to have_content 'Books'
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(book.user)
        expect(page).to have_link '', href: user_path(book2.user)
      end
      it '自分と他人のタイトルのリンク先が正しい' do
        expect(page).to have_link book.title, href: book_path(book)
        expect(page).to have_link book2.title, href: book_path(book2)
      end
      it '自分と他人のオピニオンが表示される' do
        expect(page).to have_content book.body
        expect(page).to have_content book2.body
      end
    end
  end

  describe '詳細画面のテスト' do
    context '自分・他人共通の投稿詳細画面の表示を確認' do
      it 'Book detailと表示される' do
        visit book_path(book)
        expect(page).to have_content 'Book detail'
      end
      it 'ユーザー画像・名前のリンク先が正しい' do
        visit book_path(book)
        expect(page).to have_link book.user.name, href: user_path(book.user)
      end
      it '投稿のtitleが表示される' do
        visit book_path(book)
        expect(page).to have_content book.title
      end
      it '投稿のopinionが表示される' do
        visit book_path(book)
        expect(page).to have_content book.body
      end
    end
    context '自分の投稿詳細画面の表示を確認' do
      it '投稿の編集リンクが表示される' do
        visit book_path book
        expect(page).to have_link 'Edit', href: edit_book_path(book)
      end
      it '投稿の削除リンクが表示される' do
        visit book_path book
        expect(page).to have_link 'Destroy', href: book_path(book)
      end
    end
    context '他人の投稿詳細画面の表示を確認' do
      it '投稿の編集リンクが表示されない' do
        visit book_path(book2)
        expect(page).to have_no_link 'Edit', href: edit_book_path(book2)
      end
      it '投稿の削除リンクが表示されない' do
        visit book_path(book2)
        expect(page).to have_no_link 'Destroy', href: book_path(book2)
      end
    end
  end
end