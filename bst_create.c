/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   bst_create.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: qle-guen <qle-guen@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2016/03/22 13:47:33 by qle-guen          #+#    #+#             */
/*   Updated: 2016/04/26 14:16:44 by qle-guen         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libbst.h"

t_bst_tree			*bst_new
	(void *data, size_t size)
{
	t_bst_tree		*new;

	if (!(new = ft_memalloc(sizeof(*new))))
		return (NULL);
	new->data = ft_memalloc(size);
	if (!data)
		return (new);
	ft_memcpy(new->data, data, size);
	return (new);
}

void				bst_insert_node
	(t_bst_tree **t, t_bst_tree *n, t_cmp f)
{
	t_bst_tree		*cur_node;

	cur_node = *t;
	if (!n)
		return ;
	if (!cur_node)
		*t = n;
	else if (f(n->data, cur_node->data) <= 0)
		bst_insert_node(&cur_node->left, n, f);
	else
		bst_insert_node(&cur_node->right, n, f);
}

void				bst_insert_elem
	(t_bst_tree **t, void *data, size_t size, t_cmp f)
{
	t_bst_tree		*new;

	new = bst_new(data, size);
	bst_insert_node(t, new, f);
}

t_bst_tree			*bst_fromarray
	(void *arr, size_t length, size_t elem_size, t_cmp f)
{
	size_t			i;
	t_bst_tree		*t;

	i = 0;
	t = NULL;
	while (i < length)
	{
		bst_insert_elem(&t, arr, elem_size, f);
		arr += elem_size;
		i++;
	}
	return (t);
}

t_bst_tree			*bst_fromlist
	(t_list *l, t_cmp f)
{
	t_bst_tree		*ret;

	ret = NULL;
	while (l)
	{
		bst_insert_elem(&ret, l->data, l->size, f);
		l = l->next;
	}
	return (ret);
}
