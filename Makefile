# Directories
BINDIR		=	.
SRCDIR		=	src
BUILDDIR	=	build
LIBDIR		=	lib
INCLUDE		=	includes
NAME		=	libavl.a
TARGET		=	$(BINDIR)/$(NAME)

# Compiler options
CC			=	clang
LIBFLAGS	=	-L$(BUILDDIR) $(subst lib,-l,$(LIBSRC))
CFLAGS		=	-I$(INCLUDE) -Wall -Wextra -Werror -g

# Color output
BLACK		=	"\033[0;30m"
RED			=	"\033[0;31m"
GREEN		=	"\033[0;32m"
YELLOW		=	"\033[1;33m"
BLUE		=	"\033[0;34m"
MAGENTA		=	"\033[0;35m"
CYAN		=	"\033[0;36m"
WHITE		=	"\033[0;37m"
END			=	"\033[0m"

# Source files
SRC			+=	avl_create.c
SRC			+=	avl_traverse.c

# Libraries
LIBSRC		+=	libft

OBJECTS		=	$(addprefix $(BUILDDIR)/, $(SRC:%.c=%.o))
LIBS		=	$(addprefix $(BUILDDIR)/, $(addsuffix .a,$(LIBSRC)))

all: $(TARGET)

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@[ -d $(BUILDDIR) ] || mkdir $(BUILDDIR); true
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo $(GREEN)+++ obj: $(YELLOW)$(@F)$(END)

$(BUILDDIR)/%.a: $(LIBDIR)/% $(LIBDIR)/$(LIBSRC)
	@[ -d $(BUILDDIR) ] || mkdir $(BUILDDIR); true
	@make -s -C $< > /dev/null
	@cp $</$(@F) $@
	@echo $(GREEN)+++ lib: $(CYAN)$(@F)$(END)

$(TARGET): $(LIBS) $(OBJECTS)
	@ar rc $(@:%.a=%.tmp) $(OBJECTS)
	@ar rcT $@ $(@:%.a=%.tmp) $<
	@echo $(GREEN)+++ bin: $(BLUE)$(NAME)$(END)

$(BINDIR)/$(TESTBIN): $(TARGET)
	@$(CC) $(CFLAGS) $(SRCDIR)/main.c -o $@ -L$(BINDIR) -l$(NAME:lib%.a=%)
	@echo $(GREEN)+++ bin: $(BLUE)$(@F)$(END)

$(BUILDDIR):
	@mkdir $(BUILDDIR)

$(LIBDIR)/$(LIBSRC):
	@git clone http://github.com/qleguennec/$(@F).git $@
	@cp $@/includes/$(@F).h $(INCLUDE) 2> /dev/null || true

.PHONY: clean
clean:
	@rm $(LIBS) 2> /dev/null && echo $(RED)--- lib: $(CYAN)$(LIBS:$(BUILDDIR)/%=%)$(END); true
	@rm $(OBJECTS) 2> /dev/null && echo $(RED)--- obj: $(YELLOW)$(OBJECTS:$(BUILDDIR)/%=%)$(END); true
	@[ ! "$(ls -A $(BUILDDIR))" ] && rm -r $(BUILDDIR) 2> /dev/null; true

.PHONY:	fclean
fclean: clean
	@rm $(TARGET) 2> /dev/null && echo $(RED)--- bin: $(BLUE)$(NAME)$(END); true
	@rm $(BINDIR)/$(TESTBIN) 2> /dev/null && echo $(RED)--- bin: $(BLUE)$(NAME)$(END); true
	@[ ! "$(ls -A $(BUILDDIR))" ] && rm -r $(BUILDDIR) 2> /dev/null; true

.PHONY: re
re: fclean all

.PHONY: test
test: re
	@make -s -C test/ test

get-%:
	@echo '$($*)'