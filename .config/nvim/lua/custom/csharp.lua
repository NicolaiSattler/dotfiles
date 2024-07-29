require("luasnip.session.snippet_collection").clear_snippets "csharp"

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("all", {
        s("ternary", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	})
})

ls.add_snippets("csharp", {
	s("testm", {
		t("[TestMethod]"),
		t("\npublic void "),i(1, "function name"), t("()"),
		t("\n{"),
		t("\n\t//Arrange"),
		t("\n\t//Act"),
		t("\n\t//Assert"),
		t("\n}")
	})
})
