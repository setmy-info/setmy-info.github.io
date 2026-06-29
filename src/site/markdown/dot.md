# DOT Language

## Information

## Installation

[Downloads](https://graphviz.org/download/)

### CentOS, Rocky Linux

### Windows

## Configuration

## Usage, tips and tricks

```shell
dot -Tsvg classes.dot -o classes.svg
dot -Tpng classes.dot -o classes.svg
```

### Coding tips and tricks

**packages.dot**

PackagesDiagram - can be any other name for graph.

```dot
/*
dot -Tsvg packages.dot -o packages.svg
*/

digraph PackagesDiagram {
    node [shape = folder];

    SYS [label = "system", shape = component];
    x_package [label = "com.example.x"];
    y_package [label = "com.example.y"];
    a_b_package [label = "com.example.a.b"];
    example_c_package [label = "com.example.c"];

    SYS -> x_package;

    x_package -> y_package;
    x_package -> example_c_package;

    y_package -> a_b_package;
    y_package -> example_c_package;

    a_b_package -> example_c_package;
}
```

```dot
digraph MinuGraaf {

    node [shape = box];

    Modularization [label = "Modularization"];
    Confidence [label = "Confidence"];
    Modularization -> Confidence;
}
```

```dot
digraph PackagesDiagramm {
    node [shape = folder];

    application [label = "Application/API", shape = component];
    smi_xyz_package [label = "info.setmy.xyz.abc"];
    smi_commons_package [label = "info.setmy.commons"];
    smi_core_package [label = "info.setmy.core"];

    application -> smi_xyz_package;
    application -> smi_commons_package;
    application -> smi_core_package;

    smi_xyz_package -> smi_commons_package;
    smi_xyz_package -> smi_core_package;

    smi_commons_package -> smi_core_package;

    application_layer [label = "Application Layer"];
    service_layer [label = "Service Layer"];
    data_layer [label = "Data Layer"];

    application_layer -> service_layer -> data_layer;
}
```

```dot
digraph PackagesDiagramm {
    node [shape = folder];

    application_tps [label = "Application", shape = component];
    spring_boot_starter_third_party [label = "spring-boot-starter-third-party (OK?)"; fontcolor = "red";];
    third_party_integration_package [label = "info.setmy.third.party.integration"];
    smi_application_models_package [label = "info.setmy.gateway.models"; color = "green"; fontcolor = "green";];
    smi_bom_package [label = "info.setmy.bom"; color = "green"; fontcolor = "green";];
    third_party_package [label = "info.setmy.third.party"];
    third_party_iso8583_model_package [label = "info.setmy.third.party.iso8583.model - ?"; color = "lightgray"; fontcolor = "lightgray";];
    third_party_commons_package [label = "info.setmy.third.party.commons"];
    third_party_uknown_libs [label = "?"; color = "red"; fontcolor = "red";];
    third_party_acceptance_test_package [label = "info.setmy.third.party.acceptance-test"];
    spring_boot_libs [label = "spring-boot-*"];

    application_tps -> spring_boot_starter_third_party;
    spring_boot_starter_third_party -> third_party_integration_package;
    spring_boot_starter_third_party -> spring_boot_libs;
    third_party_integration_package -> third_party_package;
    third_party_integration_package -> smi_application_models_package;
    third_party_acceptance_test_package -> spring_boot_starter_third_party;
    third_party_package -> third_party_commons_package;
    third_party_package -> third_party_iso8583_model_package;
    third_party_iso8583_model_package -> third_party_commons_package;
    third_party_iso8583_model_package -> third_party_uknown_libs;
    third_party_package -> third_party_uknown_libs;

    subgraph cluster_phase3 {
    label = "Multi-module Apache Maven GIT Monorepo";
    style = "rounded";

    /* Phase 2 gropuping - partly parallely work */
    subgraph cluster_phase2 {
    label = "thirdd party API preparation for integration into Application";
    style = "rounded";

    spring_boot_starter_third_party;
    third_party_integration_package;
    smi_application_models_package;
    smi_bom_package;
    third_party_acceptance_test_package;

    /** Phase 1 grouping **/
    subgraph cluster_phase1 {
    label = "thirdd Party API";
    style = "rounded";
    color = "gray";
    fontcolor = "black";
    fontsize = 12;

    third_party_package;
    third_party_iso8583_model_package;
    third_party_commons_package;
    }
    }
    }
    application_layer [label = "Application Layer (Rest Controller, JavaFX controller, CLI, Tests)"];
    service_layer [label = "Components or Service Layer (Think about it as an API or logic layer)"];
    data_layer [label = "Data Layer (DB and API calls)"];
    application_layer -> service_layer -> data_layer;
}
```

**graph.dot**

GraphDiagram - can be any other name for graph.

```
/*
dot -Tsvg graph.dot -o graph.svg
*/
digraph GraphDiagram {

    Begin;
    End;

    node [shape = rect];

    Begin -> BOX1 [label = "When all starts"];

    BOX1 [label = "Interesting box"];

    BOX1 -> End [label = "When all ends"];
}
```

Shapes

```
    box
    polygon
    ellipse
    oval
    circle
    point
    egg
    triangle
    plaintext
    diamond
    trapezium
    parallelogram
    house
    pentagon
    hexagon
    septagon
    octagon
    doublecircle
    doubleoctagon
    tripleoctagon
    invtriangle
    invtrapezium
    invhouse
    Mdiamond
    Msquare
    Mcircle
    rect
    rectangle
    square
    star
    none
    underline
    cylinder
    note
    tab
    folder
    box3d
    component
    promoter
    cds
    terminator
    utr
    primersite
    restrictionsite
    fivepoverhang
    threepoverhang
    noverhang
    assembly
    signature
    insulator
    ribosite
    rnastab
    proteasesite
    proteinstab
    rpromoter
    rarrow
    larrow
    lpromoter
    record
    Mrecord
    squarebox
    circle
    diamond
    triangle
    none
```

## See also

* [DOT Language](https://graphviz.org/doc/info/lang.html)
* [graphviz](https://graphviz.org/)
* [Shapes](https://graphviz.org/doc/info/shapes.html)
* [Node attributes](https://graphviz.org/docs/nodes/)
* [Edge attributes](https://graphviz.org/docs/edges/)
* [Arrows](https://graphviz.org/doc/info/arrows.html)
* [graphstream](https://graphstream-project.org/)
* [dot-parser](https://github.com/Calpano/dot-parser)
* [graphviz-java](https://github.com/nidi3/graphviz-java)
