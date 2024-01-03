local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("cs", {
  s("ternary", {
    i(1, "condition"), t(" ? "), i(2, "then"), t(" : "), i(3, "else"), t(";")
  });

  s("testc", {
    t("using Microsoft.VisualStudio.TestTools.UnitTesting;"),
    t({ "", ""}),
    t({ "", "namespace "}), i(1, "name of namespace"),t(";"),
    t({ "", ""}),
    t({ "", "[TestClass]"}),
    t({ "", "public class "}),i(2, "name of class"),
    t({ "", "{"}),
    t({ "", "\t[TestInitialize]" }),
    t({ "", "\tpublic void Initialize()" }),
    t({ "", "\t{" }),
    t({ "", "\t}" }),
    t({ "", ""}),
    t({ "", "}" }),
  }),

  s("testm", {
    t({ "", "[TestMethod]" }),
    t({ "", "public void " }), i(1, "name"), t("()"),
    t({ "", "{" }),
    t({ "", "\t//Arrange" }),
    t({ "", "\t" }),i(2,"start..."),
    t({ "", "\t//Act" }),
    t({ "", "\t" }),
    t({ "", "\t//Assert" }),
    t({ "", "}" }),
  })
})
