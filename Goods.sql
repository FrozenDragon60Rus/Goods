begin -- declare
	declare @Goods table(
		Id int identity(1,1) not null,
		Name nvarchar(256) not null,
		Price smallmoney not null,
		Count int not null
	);

	declare @Сategory table(
		Id int identity(1,1) not null,
		Name nvarchar(50) not null,
		SubCategoryId int
	);

	declare @GoodsCategory table(
		Id int identity(1,1) not null,
		CategoryId int,
		GoodsId int
	);
end

begin -- insert
	insert into @Goods(Name, Price, Count)
	values ('Шоколад Россия щедрая душа Российский горький 70% 82г', 80, 28),
		   ('Шоколад Россия щедрая душа молочный Кофе с молоком 82г', 80, 35),
		   ('Масло подсолнечное ОЛЕЙНА, рафинированное, дезодорированное, 1л', 120, 99),
		   ('Сок J7 Апельсиновый с мякотью, 0,3 л', 64, 114),
		   ('Пельмени МИРАТОРГ Классические 0,7 кг', 403, 12),
		   ('Шоколад Аленка Молочный 90г', 90, 256),
		   ('WHISKAS Корм д/кошек влажн желе кур 75г(Марс):28', 25, 512),
		   ('Лопата', 0, 0);

	insert into @Сategory(Name, SubCategoryId)
	values ('Шоколадные плитки', null),
		   ('Бакалея, соусы', null),
		   ('Сахар и заменители', null),
		   ('Гигиена', null),
		   ('Зоотовары', null),
		   ('Замороженные продукты', null),
		   ('Напитки', null);

	insert into @GoodsCategory(CategoryId, GoodsId)
	values (1, 1),
		   (1, 2),
		   (1, 6),
		   (2, 3),
		   (5, 7),
		   (6, 5),
		   (7, 4);
end

select 
	g.Name as 'Товар'
	,c.Name as 'Категория'
from @Goods as g
	left join(
		select 
			c.Name
			,gc.GoodsId
		from @Сategory as c
			left join(
				select 
					gc.CategoryId
					,gc.GoodsId
				from @GoodsCategory as gc
			) as gc on gc.CategoryId = c.Id
	) as c on c.GoodsId = g.Id
order by c.Name
	