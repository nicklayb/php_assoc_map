defmodule TupleTest do
  use ExUnit.Case
  doctest PhpAssocMap

  @flatten_source "['lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single quoted string','lvl_2_3'=>\"Double quoted string\"],'lvl_1_2'=>false]"

  test "parse unflatten array" do
    source = """
    [
      'lvl_1_1' => [
        'lvl_2_1' => 1,
        'lvl_2_2' => 'Single quoted string',
        'lvl_2_3' => "Double quoted string"
      ],
      'lvl_1_2' => false,
      'lvl_1_3' => [
        'lvl_2_1' => true,
        'lvl_2_2' => 54.12
      ]
    ]
    """

    expected = [
      {"lvl_1_1", [
          {"lvl_2_1", 1},
          {"lvl_2_2", "Single quoted string"},
          {"lvl_2_3", "Double quoted string"},
        ]
      },
      {"lvl_1_2", false},
      {"lvl_1_3", [
          {"lvl_2_1", true},
          {"lvl_2_2", 54.12},
        ]
      },
    ]

    assert PhpAssocMap.to_tuple(source) == expected
  end

  test "parses associative array to map" do
    expected = [
      {"lvl_1_1", [
          {"lvl_2_1", 1},
          {"lvl_2_2", "Single quoted string"},
          {"lvl_2_3", "Double quoted string"},
        ]
      },
      {"lvl_1_2", false}
    ]

    assert PhpAssocMap.to_tuple(@flatten_source) == expected
  end

  test "parses direct list to tuple list" do
    source = "[\"new_visit\"=>\"Nouvelle visite\",\"consult_visits\"=>\"Consulter les visites\",\"manage\"=>\"Gérer\",\"yes\"=>\"Oui\",\"no\"=>\"Non\",\"statistics\"=>\"Statistiques\",\"logout\"=>\"Déconnexion\",\"copyright\"=>\"Copyright &copy 2015 Comméléo Tout droits réservés\",\"save_changes\"=>\"Sauvegarder\",\"close\"=>\"Fermer\",\"on\"=>\"Oui\",\"off\"=>\"Non\",\"loading\"=>\"Chargement...\",\"error\"=>\"Erreur\",\"success\"=>\"Succès\",\"warning\"=>\"Attention\",\"without\"=>\"Sans\",\"toggle_navigation\"=>\"Afficher la navigation\",\"only\"=>\"Seulement\",\"all\"=>\"Tout\",\"none\"=>\"Aucun\",\"generate\"=>\"Générer\",\"hours\"=>\":hours heures\",\"login\"=>\"Connexion\",\"choose\"=>\"Choisir\",\"employees\"=>\"Employés\",\"qualifications\"=>\"Qualifications\",\"users\"=>\"Utilisateurs\",\"logs\"=>\"Journaux\"]"
    expected = [
      {"new_visit", "Nouvelle visite"},
      {"consult_visits", "Consulter les visites"},
      {"manage", "Gérer"},
      {"yes", "Oui"},
      {"no", "Non"},
      {"statistics", "Statistiques"},
      {"logout", "Déconnexion"},
      {"copyright", "Copyright &copy 2015 Comméléo Tout droits réservés"},
      {"save_changes", "Sauvegarder"},
      {"close", "Fermer"},
      {"on", "Oui"},
      {"off", "Non"},
      {"loading", "Chargement..."},
      {"error", "Erreur"},
      {"success", "Succès"},
      {"warning", "Attention"},
      {"without", "Sans"},
      {"toggle_navigation", "Afficher la navigation"},
      {"only", "Seulement"},
      {"all", "Tout"},
      {"none", "Aucun"},
      {"generate", "Générer"},
      {"hours", ":hours heures"},
      {"login", "Connexion"},
      {"choose", "Choisir"},
      {"employees", "Employés"},
      {"qualifications", "Qualifications"},
      {"users", "Utilisateurs"},
      {"logs", "Journaux"}
    ]

    assert PhpAssocMap.to_tuple(source) == expected
  end
end
