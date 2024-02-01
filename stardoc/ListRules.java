// import com.example.tutorial.protos.AddressBook;
// import com.example.tutorial.protos.Person;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.*;

// option java_outer_classname = "StardocOutputProtos";
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class RuleComparator implements java.util.Comparator<RuleInfo> {
    // Collator myCollator = Collator.getInstance();
    @Override
    public int compare(RuleInfo a, RuleInfo b) {
        // return myCollator.compare(a, b);
        // return a.getRuleName() - b.getRuleName();
        return a.getRuleName().compareTo(b.getRuleName());
    }
}

class ListRules {
  // Iterates though all rules in the StardocOutputProtos and prints info about them.
    static void Print(ModuleInfo mi) {
        System.out.println("Rule ct: " + mi.getRuleInfoCount());
        List<RuleInfo> _rules = mi.getRuleInfoList();


        List<RuleInfo> rules = new ArrayList(_rules);

        Collections.sort(rules, new RuleComparator());

        for (RuleInfo rule: rules) {
            System.out.println("");
            System.out.println("<rule>");
            System.out.println("  <name>" + rule.getRuleName()
                               + "</name>");
            System.out.println("  <docstring>");
            System.out.println("    " + rule.getDocString());
            System.out.println("  </docstring>");
            System.out.println("");

            System.out.println("  <attrs>");
            for (AttributeInfo attr: rule.getAttributeList()) {
                System.out.println("  <attr>");
                System.out.println("    <name>"
                                   + attr.getName()
                                   + "</name>");
                System.out.println("    <docstring>"
                                   + attr.getDocString()
                                   + "</docstring>");
                System.out.println("  </attr>");
            }
            System.out.println("  </attrs>");
            System.out.println("</rule>");
        }

        System.out.println("<providers>");
        List<ProviderInfo> _providers = mi.getProviderInfoList();

        for (ProviderInfo provider: _providers) {
            System.out.println("");
            System.out.println("<provider>");
            System.out.println("  <name>" + provider.getProviderName()
                               + "</name>");
            System.out.println("  <origin>");
            System.out.println("    <name>"
                               + provider.getOriginKey().getName() + "</name>");
            System.out.println("    <file>"
                               + provider.getOriginKey().getFile() + "</file>");
            System.out.println("  </origin>");

            System.out.println("  <docstring>");
            System.out.println("    " + provider.getDocString());
            System.out.println("  </docstring>");
            System.out.println("");

            for (ProviderFieldInfo fld: provider.getFieldInfoList()) {
                System.out.println("  <fld>");
                System.out.println("    <name>"
                                   + fld.getName()
                                   + "</name>");
                System.out.println("    <docstring>"
                                   + fld.getDocString()
                                   + "</docstring>");
                System.out.println("  </fld>");
            }

            System.out.println("</provider>");
        }
        System.out.println("</providers>");
  }

  // Main function:  Reads the entire address book from a file and prints all
  //   the information inside.
  public static void main(String[] args) throws Exception {
    if (args.length != 1) {
      System.err.println("Usage:  ListRules ADDRESS_BOOK_FILE");
      System.exit(-1);
    }

    ModuleInfo mi =
      ModuleInfo.parseFrom(new FileInputStream(args[0]));

    System.out.println("<hdr>" + mi.getModuleDocstring() + "</hdr>");

    Print(mi);
  }
}
