crumb :root do
  link "トップページ", root_path
end

crumb :devise do # user周りをdeviseで実装してるから
  link "新規登録", new_user_registration_path
  parent :root
end

crumb :devise do # ↑と指定する文字列が違うがok、パスが違うから
  link "ログイン", new_user_session_path
  parent :root
end

crumb :items_new do 
  link "商品出品", new_item_path
  parent :root
end

crumb :items_show do |item| #ブロック変数要る：ordersのパンくずでitemのidをここから飛ばす(パンくずoedersへ)
  link "商品詳細", item_path(item)
  parent :root
end

crumb :items_edit do |item| # 商品毎の詳細表示なのでブロック変数にして呼び出す
  link "商品詳細編集"    # パス要らず：親items_showで変数指定してitemのidをもらっている
  parent :items_show, item
end

crumb :orders do |item|
  link "購入"           # パス要らず：親items_showで変数指定してitemのidをもらっている
  parent :items_show, item #親となるパンくずとブロック変数要る
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).