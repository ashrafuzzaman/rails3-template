Nested scaffold
===========================
rails generate nested_scaffold comment title:string blog:references user:references

Explanation:
The parent resource is choosen from the first decleared references type. Here the parent resource is blog.

Now it only supports erb template.

Note
===========================
Nested scaffold already exists for rails 3, still I had to build yet another because those were broken. The reason I did not forked from there because those plugin overides a lot of rails generator code. But as we know the rails code base is always changing. So the way I implement it is simple. First let rails generate what it usually does and then change some of the generated files. For me I changed the controller and the view files.