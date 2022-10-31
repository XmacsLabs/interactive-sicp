<TeXmacs|2.1.2>

<style|<tuple|generic|british>>

<\body>
  <\script-output|dot|default>
    digraph {

    \ \ rankdir=LR

    \ \ node [shape=box]

    \;

    \ \ "enumerate:\\ntree leaves"

    \ \ -\<gtr\> "filter:\\nodd?"

    \ \ -\<gtr\> "map:\\nsquare"

    \ \ -\<gtr\> "accumulate:\\n+, 0"

    \ \ \ \ 

    \ \ "enumerate:\\nintegers"

    \ \ -\<gtr\> "map:\\nfib"

    \ \ -\<gtr\> "filter:\\neven?"

    \ \ -\<gtr\> "accumulate:\\ncons, ()"

    }
  </script-output|<image|<tuple|<#252150532D41646F62652D332E3020455053462D332E300A252543726561746F723A20677261706876697A2076657273696F6E20322E34372E31202832303231303431372E31393139290A25255469746C653A2025330A252550616765733A20310A2525426F756E64696E67426F783A20333620333620343230203133380A2525456E64436F6D6D656E74730A736176650A2525426567696E50726F6C6F670A2F446F7444696374203230302064696374206465660A446F744469637420626567696E0A0A2F73657475704C6174696E31207B0A6D61726B0A2F456E636F64696E67566563746F7220323536206172726179206465660A20456E636F64696E67566563746F7220300A0A49534F4C6174696E31456E636F64696E6720302032353520676574696E74657276616C20707574696E74657276616C0A456E636F64696E67566563746F72203435202F68797068656E207075740A0A25205365742075702049534F204C6174696E20312063686172616374657220656E636F64696E670A2F737461726E657449534F207B0A2020202020202020647570206475702066696E64666F6E7420647570206C656E677468206469637420626567696E0A20202020202020207B203120696E646578202F464944206E65207B20646566207D7B20706F7020706F70207D206966656C73650A20202020202020207D20666F72616C6C0A20202020202020202F456E636F64696E6720456E636F64696E67566563746F72206465660A202020202020202063757272656E746469637420656E6420646566696E65666F6E740A7D206465660A2F54696D65732D526F6D616E20737461726E657449534F206465660A2F54696D65732D4974616C696320737461726E657449534F206465660A2F54696D65732D426F6C6420737461726E657449534F206465660A2F54696D65732D426F6C644974616C696320737461726E657449534F206465660A2F48656C76657469636120737461726E657449534F206465660A2F48656C7665746963612D4F626C6971756520737461726E657449534F206465660A2F48656C7665746963612D426F6C6420737461726E657449534F206465660A2F48656C7665746963612D426F6C644F626C6971756520737461726E657449534F206465660A2F436F757269657220737461726E657449534F206465660A2F436F75726965722D4F626C6971756520737461726E657449534F206465660A2F436F75726965722D426F6C6420737461726E657449534F206465660A2F436F75726965722D426F6C644F626C6971756520737461726E657449534F206465660A636C656172746F6D61726B0A7D2062696E64206465660A0A2525426567696E5265736F757263653A2070726F6373657420677261706876697A203020300A2F636F6F72642D666F6E742D66616D696C79202F54696D65732D526F6D616E206465660A2F64656661756C742D666F6E742D66616D696C79202F54696D65732D526F6D616E206465660A2F636F6F7264666F6E7420636F6F72642D666F6E742D66616D696C792066696E64666F6E742038207363616C65666F6E74206465660A0A2F496E765363616C65466163746F7220312E30206465660A2F7365745F7363616C65207B0A202020202020206475702031206578636820646976202F496E765363616C65466163746F722065786368206465660A202020202020207363616C650A7D2062696E64206465660A0A25207374796C65730A2F736F6C6964207B205B5D20302073657464617368207D2062696E64206465660A2F646173686564207B205B3920496E765363616C65466163746F72206D756C20647570205D20302073657464617368207D2062696E64206465660A2F646F74746564207B205B3120496E765363616C65466163746F72206D756C203620496E765363616C65466163746F72206D756C5D20302073657464617368207D2062696E64206465660A2F696E766973207B2F66696C6C207B6E6577706174687D20646566202F7374726F6B65207B6E6577706174687D20646566202F73686F77207B706F70206E6577706174687D206465667D2062696E64206465660A2F626F6C64207B2032207365746C696E657769647468207D2062696E64206465660A2F66696C6C6564207B207D2062696E64206465660A2F756E66696C6C6564207B207D2062696E64206465660A2F726F756E646564207B207D2062696E64206465660A2F646961676F6E616C73207B207D2062696E64206465660A2F74617065726564207B207D2062696E64206465660A0A2520686F6F6B7320666F722073657474696E6720636F6C6F72200A2F6E6F6465636F6C6F72207B20736574687362636F6C6F72207D2062696E64206465660A2F65646765636F6C6F72207B20736574687362636F6C6F72207D2062696E64206465660A2F6772617068636F6C6F72207B20736574687362636F6C6F72207D2062696E64206465660A2F6E6F70636F6C6F72207B706F7020706F7020706F707D2062696E64206465660A0A2F626567696E70616765207B09252069206A206E70616765730A092F6E70616765732065786368206465660A092F6A2065786368206465660A092F692065786368206465660A092F73747220313020737472696E67206465660A096E70616765732031206774207B0A090967736176650A090909636F6F7264666F6E7420736574666F6E740A090909302030206D6F7665746F0A090909285C28292073686F77206920737472206376732073686F7720282C292073686F77206A20737472206376732073686F7720285C29292073686F770A090967726573746F72650A097D2069660A7D2062696E64206465660A0A2F7365745F666F6E74207B0A0966696E64666F6E7420657863680A097363616C65666F6E7420736574666F6E740A7D206465660A0A25206472617720746578742066697474656420746F206974732065787065637465642077696474680A2F616C69676E656474657874207B0909092520776964746820746578740A092F746578742065786368206465660A092F77696474682065786368206465660A0967736176650A090977696474682030206774207B0A0909095B5D203020736574646173680A0909097465787420737472696E67776964746820706F702077696474682065786368207375622074657874206C656E6774682064697620302074657874206173686F770A09097D2069660A0967726573746F72650A7D206465660A0A2F626F787072696D207B09090909252078636F726E65722079636F726E6572207873697A65207973697A650A090934203220726F6C6C0A09096D6F7665746F0A09093220636F70790A090965786368203020726C696E65746F0A090930206578636820726C696E65746F0A0909706F70206E6567203020726C696E65746F0A0909636C6F7365706174680A7D2062696E64206465660A0A2F656C6C697073655F70617468207B0A092F72792065786368206465660A092F72782065786368206465660A092F792065786368206465660A092F782065786368206465660A096D61747269782063757272656E746D61747269780A096E6577706174680A09782079207472616E736C6174650A097278207279207363616C650A093020302031203020333630206172630A097365746D61747269780A7D2062696E64206465660A0A2F656E6470616765207B2073686F7770616765207D2062696E64206465660A2F73686F7770616765207B207D206465660A0A2F6C61796572636F6C6F727365710A095B0925206C6179657220636F6C6F722073657175656E6365202D206461726B65737420746F206C696768746573740A09095B30203020305D0A09095B2E32202E38202E385D0A09095B2E34202E38202E385D0A09095B2E36202E38202E385D0A09095B2E38202E38202E385D0A095D0A6465660A0A2F6C617965726C656E206C61796572636F6C6F72736571206C656E677468206465660A0A2F7365746C61796572207B2F6D61786C61796572206578636820646566202F6375726C617965722065786368206465660A096C61796572636F6C6F72736571206375726C61796572203120737562206C617965726C656E206D6F64206765740A09616C6F616420706F7020736574687362636F6C6F720A092F6E6F6465636F6C6F72207B6E6F70636F6C6F727D206465660A092F65646765636F6C6F72207B6E6F70636F6C6F727D206465660A092F6772617068636F6C6F72207B6E6F70636F6C6F727D206465660A7D2062696E64206465660A0A2F6F6E6C61796572207B206375726C61796572206E65207B696E7669737D206966207D206465660A0A2F6F6E6C6179657273207B0A092F6D7975707065722065786368206465660A092F6D796C6F7765722065786368206465660A096375726C61796572206D796C6F776572206C740A096375726C61796572206D7975707065722067740A096F720A097B696E7669737D2069660A7D206465660A0A2F6375726C617965722030206465660A0A2525456E645265736F757263650A2525456E6450726F6C6F670A2525426567696E53657475700A31342064656661756C742D666F6E742D66616D696C79207365745F666F6E740A25202F6172726F776C656E677468203130206465660A25202F6172726F7777696474682035206465660A0A25206D616B652073757265207064666D61726B206973206861726D6C65737320666F722050532D696E74657270726574657273206F74686572207468616E2044697374696C6C65720A2F7064666D61726B207768657265207B706F707D207B7573657264696374202F7064666D61726B202F636C656172746F6D61726B206C6F6164207075747D206966656C73650A25206D616B6520273C3C2720616E6420273E3E272073616665206F6E205053204C6576656C203120646576696365730A2F6C616E67756167656C6576656C207768657265207B706F70206C616E67756167656C6576656C7D7B317D206966656C73650A32206C74207B0A20202020757365726469637420283C3C292063766E20285B292063766E206C6F6164207075740A20202020757365726469637420283E3E292063766E20285B292063766E206C6F6164207075740A7D2069660A0A2525456E6453657475700A73657475704C6174696E310A2525506167653A203120310A252550616765426F756E64696E67426F783A20333620333620343230203133380A2525506167654F7269656E746174696F6E3A20506F7274726169740A302030203120626567696E706167650A67736176650A3336203336203338342031303220626F787072696D20636C6970206E6577706174680A312031207365745F7363616C65203020726F74617465203430203430207472616E736C6174650A2520656E756D65726174653A5C6E74726565206C65617665730A67736176650A31207365746C696E6577696474680A3020302030206E6F6465636F6C6F720A6E657770617468203737203338206D6F7665746F0A30203338206C696E65746F0A302030206C696E65746F0A37372030206C696E65746F0A636C6F736570617468207374726F6B650A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A382032322E38206D6F7665746F2036312028656E756D65726174653A2920616C69676E6564746578740A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A392E3520372E38206D6F7665746F203538202874726565206C65617665732920616C69676E6564746578740A67726573746F72650A252066696C7465723A5C6E6F64643F0A67736176650A31207365746C696E6577696474680A3020302030206E6F6465636F6C6F720A6E65777061746820313637203338206D6F7665746F0A313133203338206C696E65746F0A3131332030206C696E65746F0A3136372030206C696E65746F0A636C6F736570617468207374726F6B650A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3132352032322E38206D6F7665746F203330202866696C7465723A2920616C69676E6564746578740A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3132362E3520372E38206D6F7665746F20323720286F64643F2920616C69676E6564746578740A67726573746F72650A2520656E756D65726174653A5C6E74726565206C65617665732D3E66696C7465723A5C6E6F64643F0A67736176650A31207365746C696E6577696474680A30203020302065646765636F6C6F720A6E6577706174682037372E31313637203139206D6F7665746F0A38352E343734382031392039342E33313934203139203130322E36323635203139206375727665746F0A7374726F6B650A30203020302065646765636F6C6F720A6E657770617468203130322E373834342032322E35303031206D6F7665746F0A3131322E37383434203139206C696E65746F0A3130322E373834332031352E35303031206C696E65746F0A636C6F7365706174682066696C6C0A31207365746C696E6577696474680A736F6C69640A30203020302065646765636F6C6F720A6E657770617468203130322E373834342032322E35303031206D6F7665746F0A3131322E37383434203139206C696E65746F0A3130322E373834332031352E35303031206C696E65746F0A636C6F736570617468207374726F6B650A67726573746F72650A25206D61703A5C6E7371756172650A67736176650A31207365746C696E6577696474680A3020302030206E6F6465636F6C6F720A6E65777061746820323537203338206D6F7665746F0A323033203338206C696E65746F0A3230332030206C696E65746F0A3235372030206C696E65746F0A636C6F736570617468207374726F6B650A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3231362032322E38206D6F7665746F20323820286D61703A2920616C69676E6564746578740A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A32313220372E38206D6F7665746F20333620287371756172652920616C69676E6564746578740A67726573746F72650A252066696C7465723A5C6E6F64643F2D3E6D61703A5C6E7371756172650A67736176650A31207365746C696E6577696474680A30203020302065646765636F6C6F720A6E657770617468203136372E34303239203139206D6F7665746F0A3137352E33393332203139203138342E33313036203139203139322E38323431203139206375727665746F0A7374726F6B650A30203020302065646765636F6C6F720A6E657770617468203139322E3931392032322E35303031206D6F7665746F0A3230322E393139203139206C696E65746F0A3139322E3931392031352E35303031206C696E65746F0A636C6F7365706174682066696C6C0A31207365746C696E6577696474680A736F6C69640A30203020302065646765636F6C6F720A6E657770617468203139322E3931392032322E35303031206D6F7665746F0A3230322E393139203139206C696E65746F0A3139322E3931392031352E35303031206C696E65746F0A636C6F736570617468207374726F6B650A67726573746F72650A2520616363756D756C6174653A5C6E2B2C20300A67736176650A31207365746C696E6577696474680A3020302030206E6F6465636F6C6F720A6E65777061746820333736203338206D6F7665746F0A323933203338206C696E65746F0A3239332030206C696E65746F0A3337362030206C696E65746F0A636C6F736570617468207374726F6B650A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3330312032322E38206D6F7665746F2036372028616363756D756C6174653A2920616C69676E6564746578740A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A33323320372E38206D6F7665746F20323320282B2C20302920616C69676E6564746578740A67726573746F72650A25206D61703A5C6E7371756172652D3E616363756D756C6174653A5C6E2B2C20300A67736176650A31207365746C696E6577696474680A30203020302065646765636F6C6F720A6E657770617468203235372E31333033203139206D6F7665746F0A3236342E38383932203139203237332E36363835203139203238322E34343034203139206375727665746F0A7374726F6B650A30203020302065646765636F6C6F720A6E657770617468203238322E363732392032322E35303031206D6F7665746F0A3239322E36373239203139206C696E65746F0A3238322E363732392031352E35303031206C696E65746F0A636C6F7365706174682066696C6C0A31207365746C696E6577696474680A736F6C69640A30203020302065646765636F6C6F720A6E657770617468203238322E363732392032322E35303031206D6F7665746F0A3239322E36373239203139206C696E65746F0A3238322E363732392031352E35303031206C696E65746F0A636C6F736570617468207374726F6B650A67726573746F72650A2520656E756D65726174653A5C6E696E7465676572730A67736176650A31207365746C696E6577696474680A3020302030206E6F6465636F6C6F720A6E657770617468203737203934206D6F7665746F0A30203934206C696E65746F0A30203536206C696E65746F0A3737203536206C696E65746F0A636C6F736570617468207374726F6B650A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A382037382E38206D6F7665746F2036312028656E756D65726174653A2920616C69676E6564746578740A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A31372036332E38206D6F7665746F2034332028696E7465676572732920616C69676E6564746578740A67726573746F72650A25206D61703A5C6E6669620A67736176650A31207365746C696E6577696474680A3020302030206E6F6465636F6C6F720A6E65777061746820313637203934206D6F7665746F0A313133203934206C696E65746F0A313133203536206C696E65746F0A313637203536206C696E65746F0A636C6F736570617468207374726F6B650A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3132362037382E38206D6F7665746F20323820286D61703A2920616C69676E6564746578740A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3133322E352036332E38206D6F7665746F20313520286669622920616C69676E6564746578740A67726573746F72650A2520656E756D65726174653A5C6E696E7465676572732D3E6D61703A5C6E6669620A67736176650A31207365746C696E6577696474680A30203020302065646765636F6C6F720A6E6577706174682037372E31313637203735206D6F7665746F0A38352E343734382037352039342E33313934203735203130322E36323635203735206375727665746F0A7374726F6B650A30203020302065646765636F6C6F720A6E657770617468203130322E373834342037382E35303031206D6F7665746F0A3131322E37383434203735206C696E65746F0A3130322E373834332037312E35303031206C696E65746F0A636C6F7365706174682066696C6C0A31207365746C696E6577696474680A736F6C69640A30203020302065646765636F6C6F720A6E657770617468203130322E373834342037382E35303031206D6F7665746F0A3131322E37383434203735206C696E65746F0A3130322E373834332037312E35303031206C696E65746F0A636C6F736570617468207374726F6B650A67726573746F72650A252066696C7465723A5C6E6576656E3F0A67736176650A31207365746C696E6577696474680A3020302030206E6F6465636F6C6F720A6E65777061746820323537203934206D6F7665746F0A323033203934206C696E65746F0A323033203536206C696E65746F0A323537203536206C696E65746F0A636C6F736570617468207374726F6B650A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3231352037382E38206D6F7665746F203330202866696C7465723A2920616C69676E6564746578740A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3231342036332E38206D6F7665746F20333220286576656E3F2920616C69676E6564746578740A67726573746F72650A25206D61703A5C6E6669622D3E66696C7465723A5C6E6576656E3F0A67736176650A31207365746C696E6577696474680A30203020302065646765636F6C6F720A6E657770617468203136372E34303239203735206D6F7665746F0A3137352E33393332203735203138342E33313036203735203139322E38323431203735206375727665746F0A7374726F6B650A30203020302065646765636F6C6F720A6E657770617468203139322E3931392037382E35303031206D6F7665746F0A3230322E393139203735206C696E65746F0A3139322E3931392037312E35303031206C696E65746F0A636C6F7365706174682066696C6C0A31207365746C696E6577696474680A736F6C69640A30203020302065646765636F6C6F720A6E657770617468203139322E3931392037382E35303031206D6F7665746F0A3230322E393139203735206C696E65746F0A3139322E3931392037312E35303031206C696E65746F0A636C6F736570617468207374726F6B650A67726573746F72650A2520616363756D756C6174653A5C6E636F6E732C2028290A67736176650A31207365746C696E6577696474680A3020302030206E6F6465636F6C6F720A6E65777061746820333736203934206D6F7665746F0A323933203934206C696E65746F0A323933203536206C696E65746F0A333736203536206C696E65746F0A636C6F736570617468207374726F6B650A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3330312037382E38206D6F7665746F2036372028616363756D756C6174653A2920616C69676E6564746578740A3020302030206E6F6465636F6C6F720A3134202F54696D65732D526F6D616E207365745F666F6E740A3331332E352036332E38206D6F7665746F2034322028636F6E732C205C285C292920616C69676E6564746578740A67726573746F72650A252066696C7465723A5C6E6576656E3F2D3E616363756D756C6174653A5C6E636F6E732C2028290A67736176650A31207365746C696E6577696474680A30203020302065646765636F6C6F720A6E657770617468203235372E31333033203735206D6F7665746F0A3236342E38383932203735203237332E36363835203735203238322E34343034203735206375727665746F0A7374726F6B650A30203020302065646765636F6C6F720A6E657770617468203238322E363732392037382E35303031206D6F7665746F0A3239322E36373239203735206C696E65746F0A3238322E363732392037312E35303031206C696E65746F0A636C6F7365706174682066696C6C0A31207365746C696E6577696474680A736F6C69640A30203020302065646765636F6C6F720A6E657770617468203238322E363732392037382E35303031206D6F7665746F0A3239322E36373239203735206C696E65746F0A3238322E363732392037312E35303031206C696E65746F0A636C6F736570617468207374726F6B650A67726573746F72650A656E64706167650A73686F77706167650A67726573746F72650A252550616765547261696C65720A2525456E64506167653A20310A2525547261696C65720A656E640A726573746F72650A2525454F460A>|ps>|0.618par|||>>
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        \;
      </surround>|<pageref|auto-1>>
    </associate>
  </collection>
</auxiliary>