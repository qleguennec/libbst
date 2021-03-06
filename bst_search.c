/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   bst_search.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: qle-guen <qle-guen@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2016/03/25 09:46:24 by qle-guen          #+#    #+#             */
/*   Updated: 2016/03/30 17:41:16 by qle-guen         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libbst.h"

void			*bst_search
	(t_bst_tree *t, void *elem, t_cmp f)
{
	int			cmp;

	if (!t)
		return (NULL);
	cmp = f(elem, t->data);
	if (!cmp)
		return (t->data);
	else if (cmp < 0)
		return (bst_search(t->left, elem, f));
	else
		return (bst_search(t->right, elem, f));
}

int				bst_lookup
	(t_bst_tree *t, void *elem, t_cmp f)
{
	return (bst_search(t, elem, f) != NULL);
}
