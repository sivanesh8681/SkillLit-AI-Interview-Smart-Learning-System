// lib/data/lessons_data.dart

final Map<String, Map<String, List<Map<String, String>>>> lessonsData = {

  // ================= NEET =================
  "neet": {

    "physics": [
      {"title": "Physical World & Measurement", "duration": "2h"},
      {"title": "Kinematics", "duration": "3h"},
      {"title": "Laws of Motion", "duration": "3h"},
      {"title": "Work, Energy & Power", "duration": "3h"},
      {"title": "Centre of Mass & Rotational Motion", "duration": "3h"},
      {"title": "Gravitation", "duration": "2.5h"},
      {"title": "Properties of Solids & Liquids", "duration": "2h"},
      {"title": "Thermodynamics", "duration": "3h"},
      {"title": "Kinetic Theory", "duration": "2h"},
      {"title": "Oscillations & Waves", "duration": "3h"},
      {"title": "Electrostatics", "duration": "3h"},
      {"title": "Current Electricity", "duration": "3h"},
      {"title": "Magnetic Effects of Current", "duration": "3h"},
      {"title": "Electromagnetic Induction", "duration": "2.5h"},
      {"title": "Alternating Current", "duration": "2h"},
      {"title": "Electromagnetic Waves", "duration": "1.5h"},
      {"title": "Ray Optics", "duration": "3h"},
      {"title": "Wave Optics", "duration": "2h"},
      {"title": "Dual Nature of Radiation & Matter", "duration": "2h"},
      {"title": "Atoms", "duration": "2h"},
      {"title": "Nuclei", "duration": "2h"},
      {"title": "Semiconductor Electronics", "duration": "3h"},
      {"title": "Communication Systems", "duration": "1.5h"},
    ],

    "chemistry": [
      {"title": "Some Basic Concepts of Chemistry", "duration": "2h"},
      {"title": "Atomic Structure", "duration": "2h"},
      {"title": "States of Matter", "duration": "2h"},
      {"title": "Chemical Thermodynamics", "duration": "3h"},
      {"title": "Equilibrium", "duration": "3h"},
      {"title": "Redox Reactions", "duration": "2h"},
      {"title": "Hydrogen", "duration": "1.5h"},
      {"title": "Surface Chemistry", "duration": "2h"},
      {"title": "Solid State", "duration": "2h"},
      {"title": "Solutions", "duration": "3h"},
      {"title": "Electrochemistry", "duration": "3h"},
      {"title": "Chemical Kinetics", "duration": "2.5h"},

      // 🔹 Inorganic Chemistry
      {"title": "Periodic Table & Periodicity", "duration": "2h"},
      {"title": "Chemical Bonding & Molecular Structure", "duration": "3h"},
      {"title": "s-Block Elements", "duration": "2h"},
      {"title": "p-Block Elements (Group 13–18)", "duration": "4h"},
      {"title": "d- & f-Block Elements", "duration": "2.5h"},
      {"title": "Coordination Compounds", "duration": "3h"},
      {"title": "Metallurgy", "duration": "1.5h"},
      {"title": "Environmental Chemistry", "duration": "1h"},

      // 🔹 Organic Chemistry
      {"title": "Basic Organic Chemistry", "duration": "3h"},
      {"title": "Hydrocarbons", "duration": "3h"},
      {"title": "Haloalkanes & Haloarenes", "duration": "2.5h"},
      {"title": "Alcohols, Phenols & Ethers", "duration": "3h"},
      {"title": "Aldehydes, Ketones & Carboxylic Acids", "duration": "3.5h"},
      {"title": "Amines", "duration": "2h"},
      {"title": "Biomolecules", "duration": "2h"},
      {"title": "Polymers", "duration": "1.5h"},
      {"title": "Chemistry in Everyday Life", "duration": "1.5h"},

    ],

    "biology": [
      // 🌱 Botany
      {"title": "Diversity in Living World", "duration": "3h"},
      {"title": "Biological Classification", "duration": "2h"},
      {"title": "Plant Kingdom", "duration": "4h"},
      {"title": "Morphology of Flowering Plants", "duration": "3h"},
      {"title": "Anatomy of Flowering Plants", "duration": "2.5h"},
      {
        "title": "Structural Organisation in Animals & Plants",
        "duration": "2h"
      },
      {"title": "Cell: Structure & Function", "duration": "3h"},
      {"title": "Cell Cycle & Cell Division", "duration": "2.5h"},
      {"title": "Photosynthesis in Higher Plants", "duration": "3h"},
      {"title": "Respiration in Plants", "duration": "2.5h"},
      {"title": "Plant Growth & Development", "duration": "2h"},
      {"title": "Mineral Nutrition", "duration": "2h"},
      {"title": "Transport in Plants", "duration": "2h"},
      {"title": "Sexual Reproduction in Flowering Plants", "duration": "3h"},

      // 🧠 Zoology
      {"title": "Animal Kingdom", "duration": "4h"},
      {"title": "Structural Organisation in Animals", "duration": "2h"},
      {"title": "Digestion & Absorption", "duration": "2h"},
      {"title": "Breathing & Exchange of Gases", "duration": "2h"},
      {"title": "Body Fluids & Circulation", "duration": "2.5h"},
      {"title": "Excretory Products & Elimination", "duration": "2h"},
      {"title": "Locomotion & Movement", "duration": "2h"},
      {"title": "Neural Control & Coordination", "duration": "2.5h"},
      {"title": "Chemical Coordination & Integration", "duration": "2h"},
      {"title": "Human Reproduction", "duration": "3h"},
      {"title": "Reproductive Health", "duration": "2h"},
      {"title": "Principles of Inheritance & Variation", "duration": "3.5h"},
      {"title": "Molecular Basis of Inheritance", "duration": "3h"},
      {"title": "Evolution", "duration": "2.5h"},
      {"title": "Human Health & Disease", "duration": "2h"},
      {"title": "Microbes in Human Welfare", "duration": "1.5h"},
      {"title": "Biotechnology: Principles & Processes", "duration": "2.5h"},
      {"title": "Biotechnology & Its Applications", "duration": "2h"},
      {"title": "Ecology & Environment", "duration": "3h"},
      {"title": "Environmental Issues", "duration": "2h"},

    ],
  },
  //Jee
  "jee": {
    "mathematics": [
      // 🔹 Algebra
      {"title": "Sets, Relations & Functions", "duration": "2.5h"},
      {"title": "Complex Numbers & Quadratic Equations", "duration": "3h"},
      {"title": "Matrices & Determinants", "duration": "3h"},
      {"title": "Permutations & Combinations", "duration": "2.5h"},
      {"title": "Mathematical Induction", "duration": "1.5h"},
      {"title": "Binomial Theorem", "duration": "2h"},
      {"title": "Sequences & Series", "duration": "3h"},
      {"title": "Probability", "duration": "3h"},

      // 🔹 Trigonometry
      {"title": "Trigonometric Functions", "duration": "2.5h"},
      {"title": "Trigonometric Identities & Equations", "duration": "2.5h"},
      {"title": "Inverse Trigonometric Functions", "duration": "2h"},
      {"title": "Heights & Distances", "duration": "1.5h"},

      // 🔹 Coordinate Geometry
      {"title": "Straight Lines", "duration": "3h"},
      {"title": "Circles", "duration": "2.5h"},
      {
        "title": "Conic Sections (Parabola, Ellipse, Hyperbola)",
        "duration": "4h"
      },
      {"title": "Three Dimensional Geometry", "duration": "3h"},

      // 🔹 Calculus
      {"title": "Limits & Continuity", "duration": "3h"},
      {"title": "Differentiability", "duration": "2.5h"},
      {"title": "Applications of Derivatives", "duration": "3h"},
      {"title": "Indefinite Integrals", "duration": "3h"},
      {"title": "Definite Integrals", "duration": "3h"},
      {"title": "Applications of Integrals", "duration": "2.5h"},
      {"title": "Differential Equations", "duration": "2.5h"},

      // 🔹 Vector & 3D
      {"title": "Vector Algebra", "duration": "2.5h"},
      {"title": "3D Geometry (Advanced)", "duration": "2.5h"},

      // 🔹 Mathematical Reasoning & Statistics
      {"title": "Mathematical Reasoning", "duration": "1.5h"},
      {"title": "Statistics", "duration": "2h"},
    ],
    "chemistry": [
      {"title": "Some Basic Concepts of Chemistry", "duration": "2h"},
      {"title": "Atomic Structure", "duration": "2h"},
      {"title": "States of Matter", "duration": "2h"},
      {"title": "Chemical Thermodynamics", "duration": "3h"},
      {"title": "Equilibrium", "duration": "3h"},
      {"title": "Redox Reactions", "duration": "2h"},
      {"title": "Hydrogen", "duration": "1.5h"},
      {"title": "Surface Chemistry", "duration": "2h"},
      {"title": "Solid State", "duration": "2h"},
      {"title": "Solutions", "duration": "3h"},
      {"title": "Electrochemistry", "duration": "3h"},
      {"title": "Chemical Kinetics", "duration": "2.5h"},

      // 🔹 Inorganic Chemistry
      {"title": "Periodic Table & Periodicity", "duration": "2h"},
      {"title": "Chemical Bonding & Molecular Structure", "duration": "3h"},
      {"title": "s-Block Elements", "duration": "2h"},
      {"title": "p-Block Elements (Group 13–18)", "duration": "4h"},
      {"title": "d- & f-Block Elements", "duration": "2.5h"},
      {"title": "Coordination Compounds", "duration": "3h"},
      {"title": "Metallurgy", "duration": "1.5h"},
      {"title": "Environmental Chemistry", "duration": "1h"},

      // 🔹 Organic Chemistry
      {"title": "Basic Organic Chemistry", "duration": "3h"},
      {"title": "Hydrocarbons", "duration": "3h"},
      {"title": "Haloalkanes & Haloarenes", "duration": "2.5h"},
      {"title": "Alcohols, Phenols & Ethers", "duration": "3h"},
      {"title": "Aldehydes, Ketones & Carboxylic Acids", "duration": "3.5h"},
      {"title": "Amines", "duration": "2h"},
      {"title": "Biomolecules", "duration": "2h"},
      {"title": "Polymers", "duration": "1.5h"},
      {"title": "Chemistry in Everyday Life", "duration": "1.5h"},
    ],
    "physics": [
      {"title": "Physical World & Measurement", "duration": "2h"},
      {"title": "Kinematics", "duration": "3h"},
      {"title": "Laws of Motion", "duration": "3h"},
      {"title": "Work, Energy & Power", "duration": "3h"},
      {"title": "Centre of Mass & Rotational Motion", "duration": "3h"},
      {"title": "Gravitation", "duration": "2.5h"},
      {"title": "Properties of Solids & Liquids", "duration": "2h"},
      {"title": "Thermodynamics", "duration": "3h"},
      {"title": "Kinetic Theory", "duration": "2h"},
      {"title": "Oscillations & Waves", "duration": "3h"},
      {"title": "Electrostatics", "duration": "3h"},
      {"title": "Current Electricity", "duration": "3h"},
      {"title": "Magnetic Effects of Current", "duration": "3h"},
      {"title": "Electromagnetic Induction", "duration": "2.5h"},
      {"title": "Alternating Current", "duration": "2h"},
      {"title": "Electromagnetic Waves", "duration": "1.5h"},
      {"title": "Ray Optics", "duration": "3h"},
      {"title": "Wave Optics", "duration": "2h"},
      {"title": "Dual Nature of Radiation & Matter", "duration": "2h"},
      {"title": "Atoms", "duration": "2h"},
      {"title": "Nuclei", "duration": "2h"},
      {"title": "Semiconductor Electronics", "duration": "3h"},
      {"title": "Communication Systems", "duration": "1.5h"},

    ],


  },

  // ================= UPSC =================
  "upsc": {

    "history": [
      {"title": "Ancient India", "duration": "3h"},
      {"title": "Medieval India", "duration": "3h"},
      {"title": "Modern India", "duration": "4h"},
      {"title": "World History", "duration": "3h"},
    ],

    "polity": [
      // 🏛️ Indian Constitution
      {"title": "Introduction to Indian Constitution", "duration": "2h"},
      {"title": "Evolution of Indian Constitution", "duration": "3h"},
      {"title": "Preamble of India", "duration": "1.5h"},
      {"title": "Salient Features of Constitution", "duration": "2h"},
      {"title": "Constitutional Amendments", "duration": "3h"},

      // 🧠 Fundamental Rights & Duties
      {"title": "Fundamental Rights", "duration": "3h"},
      {"title": "Fundamental Duties", "duration": "1.5h"},
      {"title": "Directive Principles of State Policy", "duration": "2.5h"},

      // 🏛️ Union Government
      {"title": "Parliament: Lok Sabha & Rajya Sabha", "duration": "3h"},
      {"title": "President of India", "duration": "2h"},
      {"title": "Vice President & Prime Minister", "duration": "1.5h"},
      {"title": "Council of Ministers & Cabinet", "duration": "2h"},

      // 🏛️ Judiciary
      {"title": "Supreme Court of India", "duration": "3h"},
      {"title": "High Courts & Subordinate Courts", "duration": "2.5h"},
      {"title": "Judicial Review & Judicial Activism", "duration": "3h"},
      {"title": "Public Interest Litigation (PIL)", "duration": "2h"},

      // 🗳️ Elections & Representation
      {"title": "Election Commission of India", "duration": "2.5h"},
      {"title": "Electoral Reforms", "duration": "2h"},
      {"title": "Reservation & Representation", "duration": "2h"},

      // 🏙️ State Government
      {"title": "Governor & State Legislature", "duration": "2h"},
      {"title": "Chief Minister & Council of Ministers", "duration": "2h"},
      {"title": "State Judiciary", "duration": "2h"},

      // 📜 Local Government
      {"title": "Panchayati Raj Institutions", "duration": "2h"},
      {"title": "Municipalities & Urban Governance", "duration": "2h"},
      {
        "title": "Decentralization & 73rd / 74th Amendments",
        "duration": "2.5h"
      },

      // 📊 Federalism
      {"title": "Centre–State Relations", "duration": "3h"},
      {"title": "Inter-State Council", "duration": "2h"},
      {"title": "Special Status & Emergency Provisions", "duration": "3h"},

      // 💡 Public Policy
      {"title": "Governance & Accountability", "duration": "2.5h"},
      {"title": "Transparency & RTI", "duration": "2h"},
      {"title": "Citizen Charter", "duration": "1.5h"},

      // 🗃️ Administrative Reforms
      {"title": "Civil Services in India", "duration": "3h"},
      {"title": "Administrative Tribunals", "duration": "2h"},

    ],

    "economy": [
      // 📘 Basic Concepts
      {"title": "What is Economy?", "duration": "1.5h"},
      {"title": "Types of Economy", "duration": "1.5h"},
      {"title": "Economic Systems", "duration": "2h"},
      {"title": "Circular Flow of Income", "duration": "2h"},

      // 📊 National Income
      {"title": "GDP, GNP, NNP Basics", "duration": "3h"},
      {"title": "Methods of National Income Accounting", "duration": "2.5h"},
      {"title": "Limitations of National Income", "duration": "1.5h"},

      // 🏦 Money & Banking
      {"title": "Definition & Functions of Money", "duration": "2h"},
      {"title": "Banking System in India", "duration": "2.5h"},
      {"title": "RBI: Role & Functions", "duration": "3h"},
      {"title": "Credit Creation & Monetary Policy", "duration": "3h"},
      {"title": "Inflation & Deflation", "duration": "3h"},

      // 📈 Fiscal Policy
      {"title": "Fiscal Policy: Basics", "duration": "2h"},
      {"title": "Budget of India", "duration": "2.5h"},
      {"title": "Taxation: Direct & Indirect", "duration": "2h"},
      {"title": "Subsidies & Public Expenditure", "duration": "2h"},

      // 📉 Economic Growth & Development
      {"title": "Growth vs Development", "duration": "2h"},
      {"title": "Indicators of Economic Development", "duration": "2h"},
      {"title": "Poverty: Concepts & Measures", "duration": "3h"},
      {"title": "Unemployment: Types & Measures", "duration": "2.5h"},
      {"title": "Human Development Index", "duration": "2h"},

      // 🧾 Indian Economy (UPSC / PSC)
      {"title": "Features of Indian Economy", "duration": "3h"},
      {"title": "Indian Economic Planning", "duration": "3h"},
      {"title": "Agriculture in India", "duration": "3h"},
      {"title": "Industrial & Service Sector in India", "duration": "3h"},
      {"title": "Infrastructure & Development", "duration": "2.5h"},
      {"title": "Banking Reforms in India", "duration": "2.5h"},
      {"title": "Money Market & Capital Market", "duration": "3h"},
      {"title": "Globalization & Indian Economy", "duration": "2.5h"},

      // 📌 Contemporary Issues
      {"title": "GST: Goods & Services Tax", "duration": "2h"},
      {"title": "Demonetization Impact", "duration": "2h"},
      {"title": "Economic Survey & Budget Highlights", "duration": "3h"},
      {"title": "Trade & Balance of Payments", "duration": "2.5h"},
      {"title": "External Sector & Forex", "duration": "2h"},
    ],


    "current_affairs": [
      {"title": "National Current Affairs", "duration": "3h"},
      {"title": "International Current Affairs", "duration": "3h"},
      {"title": "Government Schemes & Policies", "duration": "3h"},
      {"title": "Bills, Acts & Amendments", "duration": "2.5h"},
      {"title": "Supreme Court & High Court Judgements", "duration": "2.5h"},
      {"title": "Appointments & Resignations", "duration": "1.5h"},
      {"title": "Awards & Honours", "duration": "1.5h"},
      {"title": "Reports & Indices", "duration": "2h"},
      {"title": "Summits & International Organisations", "duration": "2h"},
      {"title": "Science & Tech in News", "duration": "2.5h"},
      {"title": "Environment in News", "duration": "2.5h"},
      {"title": "Economy & Banking in News", "duration": "3h"},
      {"title": "Defence & Security News", "duration": "2h"},
      {"title": "Sports Current Affairs", "duration": "1.5h"},
      {"title": "Art, Culture & Heritage News", "duration": "2h"},
      {"title": "Government Rankings & Surveys", "duration": "2h"},
      {"title": "International Relations in News", "duration": "2.5h"},
      {"title": "Year-wise Current Affairs Compilation", "duration": "4h"},

    ],

    "ethics": [
      {"title": "Ethics – Meaning & Dimensions", "duration": "2h"},
      {"title": "Human Values", "duration": "2h"},
      {"title": "Attitude – Content, Structure & Function", "duration": "2.5h"},
      {"title": "Aptitude & Foundational Values", "duration": "2h"},
      {"title": "Emotional Intelligence", "duration": "2.5h"},
      {"title": "Moral Thinkers & Philosophers (India)", "duration": "3h"},
      {"title": "Moral Thinkers & Philosophers (World)", "duration": "3h"},
      {"title": "Ethics in Public Administration", "duration": "2.5h"},
      {"title": "Probity in Governance", "duration": "2.5h"},
      {"title": "Integrity & Accountability", "duration": "2.5h"},
      {"title": "Transparency & RTI", "duration": "2h"},
      {"title": "Code of Conduct & Code of Ethics", "duration": "2h"},
      {"title": "Citizen Charter", "duration": "1.5h"},
      {"title": "Corruption – Causes & Prevention", "duration": "3h"},
      {"title": "Ethical Issues in Governance", "duration": "3h"},
      {"title": "Case Studies – Ethics (UPSC Pattern)", "duration": "4h"},

    ],
    "geography": [
      // 🌎 Physical Geography
      {"title": "Earth: Origin & Evolution", "duration": "2h"},
      {"title": "Interior of the Earth", "duration": "2h"},
      {"title": "Geomorphology (Landforms)", "duration": "4h"},
      {"title": "Climatology (Weather & Climate)", "duration": "4h"},
      {"title": "Oceanography", "duration": "3h"},
      {"title": "Biogeography", "duration": "2.5h"},
      {"title": "Natural Hazards & Disasters", "duration": "2h"},

      // 🇮🇳 Indian Geography
      {"title": "Physical Geography of India", "duration": "3.5h"},
      {"title": "Drainage System of India", "duration": "2.5h"},
      {"title": "Climate of India", "duration": "3h"},
      {"title": "Soils of India", "duration": "2h"},
      {"title": "Natural Vegetation of India", "duration": "2h"},
      {"title": "Agriculture of India", "duration": "3h"},
      {"title": "Mineral & Energy Resources", "duration": "2.5h"},
      {"title": "Industries of India", "duration": "2.5h"},
      {"title": "Transport & Communication", "duration": "2h"},

      // 🌐 Human & Economic Geography
      {"title": "Human Geography: Population", "duration": "2.5h"},
      {"title": "Human Settlements", "duration": "2h"},
      {"title": "Economic Geography", "duration": "3h"},
      {"title": "Resources & Development", "duration": "2.5h"},
      {"title": "Globalisation & World Economy", "duration": "2.5h"},

      // 🗺️ Mapping
      {"title": "World Geography Mapping", "duration": "2h"},
      {"title": "Indian Geography Mapping", "duration": "2h"},
    ],
    "science_tech": [
      {"title": "Basics of Science & Technology", "duration": "2h"},
      {"title": "Physics in Daily Life", "duration": "2h"},
      {"title": "Chemistry in Daily Life", "duration": "2h"},
      {"title": "Biology in Daily Life", "duration": "2h"},
      {"title": "Space Technology & ISRO Missions", "duration": "3h"},
      {"title": "Satellite Technology", "duration": "2.5h"},
      {"title": "Missile Technology", "duration": "2h"},
      {"title": "Defence Technology", "duration": "2h"},
      {"title": "Nuclear Science & Technology", "duration": "2.5h"},
      {"title": "Nanotechnology", "duration": "2h"},
      {"title": "Artificial Intelligence & Robotics", "duration": "3h"},
      {"title": "Machine Learning & Data Science", "duration": "2.5h"},
      {"title": "Biotechnology – Basics", "duration": "2.5h"},
      {"title": "Genetic Engineering", "duration": "2.5h"},
      {"title": "DNA, RNA & Gene Editing (CRISPR)", "duration": "3h"},
      {"title": "Human Genome Project", "duration": "2h"},
      {"title": "Stem Cell Technology", "duration": "2h"},
      {"title": "Medical Science & Health Technology", "duration": "2.5h"},
      {"title": "Vaccines & Immunology", "duration": "2h"},
      {"title": "Pandemic Science & Public Health", "duration": "2h"},
      {"title": "Information Technology", "duration": "2h"},
      {"title": "Cyber Security", "duration": "2h"},
      {"title": "Blockchain Technology", "duration": "2h"},
      {"title": "Internet of Things (IoT)", "duration": "2h"},
      {"title": "Quantum Computing", "duration": "2h"},
      {"title": "Renewable Energy Technology", "duration": "2.5h"},
      {"title": "Non-Renewable Energy Sources", "duration": "2h"},
      {"title": "Environmental Technology", "duration": "2h"},
      {"title": "Climate Change Science", "duration": "2.5h"},
      {"title": "Disaster Management Technology", "duration": "2h"},
      {"title": "Agricultural Science & Technology", "duration": "2.5h"},
      {"title": "Food Processing Technology", "duration": "2h"},
      {"title": "Space Exploration (Global)", "duration": "2h"},
      {"title": "Scientific Institutions in India", "duration": "1.5h"},
      {"title": "Nobel Prizes & Scientific Discoveries", "duration": "1.5h"},
      {"title": "Science & Technology Current Affairs", "duration": "3h"},
    ],
    "environment": [
      {"title": "Ecology – Basic Concepts", "duration": "2h"},
      {"title": "Ecosystem Structure & Functions", "duration": "2.5h"},
      {"title": "Food Chain, Food Web & Energy Flow", "duration": "2h"},
      {"title": "Biogeochemical Cycles", "duration": "2h"},
      {"title": "Biodiversity & Conservation", "duration": "3h"},
      {"title": "Biodiversity Hotspots of India", "duration": "2h"},
      {"title": "Flora & Fauna of India", "duration": "3h"},
      {"title": "Endangered Species & Red Data Book", "duration": "2h"},
      {"title": "Protected Areas in India", "duration": "2h"},
      {"title": "Environmental Pollution", "duration": "3h"},
      {"title": "Climate Change & Global Warming", "duration": "3h"},
      {"title": "Ozone Depletion & Acid Rain", "duration": "2h"},
      {"title": "Environmental Impact Assessment (EIA)", "duration": "2h"},
      {"title": "Sustainable Development", "duration": "2h"},
      {"title": "Renewable Energy Resources", "duration": "2.5h"},
      {"title": "Non-Renewable Energy Resources", "duration": "2h"},
      {"title": "Environmental Laws & Acts in India", "duration": "3h"},
      {"title": "International Environmental Conventions", "duration": "2.5h"},
      {"title": "Disaster Management – Environment Link", "duration": "2h"},
      {"title": "Environmental Current Affairs", "duration": "3h"},
    ],
    "indian_society": [
      {"title": "Indian Society – An Introduction", "duration": "2h"},
      {"title": "Salient Features of Indian Society", "duration": "2h"},
      {"title": "Unity in Diversity", "duration": "1.5h"},
      {"title": "Indian Social Structure", "duration": "2.5h"},
      {"title": "Caste System in India", "duration": "3h"},
      {"title": "Class & Social Stratification", "duration": "2h"},
      {"title": "Tribal Communities in India", "duration": "2.5h"},
      {"title": "Women in Indian Society", "duration": "3h"},
      {"title": "Issues Related to Women", "duration": "3h"},
      {"title": "Population & Associated Issues", "duration": "2.5h"},
      {"title": "Poverty & Developmental Issues", "duration": "2.5h"},
      {"title": "Urbanization – Problems & Remedies", "duration": "2.5h"},
      {"title": "Migration & Related Issues", "duration": "2h"},
      {"title": "Globalization & Indian Society", "duration": "3h"},
      {"title": "Social Empowerment", "duration": "2h"},
      {"title": "Regionalism & Communalism", "duration": "2.5h"},
      {"title": "Secularism in India", "duration": "2h"},
      {"title": "Social Justice & Inclusive Growth", "duration": "2.5h"},
      {"title": "Role of NGOs & Civil Society", "duration": "2h"},
      {"title": "Media & Indian Society", "duration": "2h"},
      {"title": "Social Change in Modern India", "duration": "3h"},
    ],
    "international_relations": [
      {"title": "International Relations – Basics", "duration": "2h"},
      {"title": "Evolution of Indian Foreign Policy", "duration": "2.5h"},
      {"title": "India’s Foreign Policy Objectives", "duration": "2h"},
      {"title": "India & Its Neighbourhood", "duration": "3h"},
      {"title": "India–Pakistan Relations", "duration": "2.5h"},
      {"title": "India–China Relations", "duration": "3h"},
      {"title": "India–USA Relations", "duration": "2.5h"},
      {"title": "India–Russia Relations", "duration": "2h"},
      {"title": "India–EU Relations", "duration": "2h"},
      {"title": "India–Japan Relations", "duration": "2h"},
      {"title": "India–ASEAN Relations", "duration": "2.5h"},
      {"title": "India & Middle East", "duration": "2h"},
      {"title": "India & Africa", "duration": "2h"},
      {"title": "India & Latin America", "duration": "1.5h"},
      {"title": "International Organizations – UN", "duration": "3h"},
      {"title": "IMF, World Bank & WTO", "duration": "2.5h"},
      {"title": "Regional Groupings (BRICS, SCO, G20)", "duration": "2.5h"},
      {"title": "Global Security Issues", "duration": "2.5h"},
      {"title": "Terrorism & Global Security", "duration": "2h"},
      {"title": "Cyber Security & Space Diplomacy", "duration": "2h"},
      {"title": "Climate Change & Global Agreements", "duration": "2h"},
      {"title": "India’s Role in Global Governance", "duration": "2.5h"},
      {"title": "International Relations – Current Affairs", "duration": "3h"},
    ],


  },

  // ================= SSC =================
  "ssc": {

    "reasoning": [
      {"title": "Introduction to Logical Reasoning", "duration": "1.5h"},
      {"title": "Analogy (Word & Number)", "duration": "2h"},
      {"title": "Classification (Odd One Out)", "duration": "2h"},
      {"title": "Series (Number, Alphabet, Mixed)", "duration": "2.5h"},
      {"title": "Coding & Decoding", "duration": "2h"},
      {"title": "Direction Sense Test", "duration": "1.5h"},
      {"title": "Blood Relations", "duration": "1.5h"},
      {"title": "Ranking & Order", "duration": "1.5h"},
      {"title": "Syllogism", "duration": "2h"},
      {"title": "Statement & Conclusion", "duration": "2h"},
      {"title": "Statement & Assumptions", "duration": "2h"},
      {"title": "Statement & Arguments", "duration": "2h"},
      {"title": "Statement & Course of Action", "duration": "2h"},
      {"title": "Cause & Effect", "duration": "1.5h"},
      {"title": "Logical Venn Diagrams", "duration": "2h"},
      {"title": "Seating Arrangement (Linear)", "duration": "2.5h"},
      {"title": "Seating Arrangement (Circular)", "duration": "2.5h"},
      {"title": "Puzzle Test (Floor, Box, Days)", "duration": "3h"},
      {"title": "Data Sufficiency", "duration": "2h"},
      {"title": "Mathematical Reasoning", "duration": "2h"},
      {"title": "Logical Decision Making", "duration": "2h"},
      {"title": "Input–Output Reasoning", "duration": "2h"},
      {"title": "Clocks & Calendars", "duration": "2h"},
      {"title": "Non-Verbal Reasoning", "duration": "2h"},
      {"title": "Mirror & Water Images", "duration": "1.5h"},
      {"title": "Paper Folding & Cutting", "duration": "1.5h"},
      {"title": "Cubes & Dice", "duration": "1.5h"},
      {"title": "Embedded Figures", "duration": "1.5h"},
      {"title": "Pattern Completion", "duration": "1.5h"},
      {"title": "Analytical Reasoning (Advanced)", "duration": "3h"},
    ],


    "quantitative_aptitude": [
      {"title": "Number System", "duration": "3h"},
      {"title": "LCM & HCF", "duration": "2h"},
      {"title": "Simplification", "duration": "2h"},
      {"title": "Surds & Indices", "duration": "2h"},
      {"title": "Ratio & Proportion", "duration": "2.5h"},
      {"title": "Percentage", "duration": "2.5h"},
      {"title": "Profit & Loss", "duration": "3h"},
      {"title": "Simple & Compound Interest", "duration": "3h"},
      {"title": "Time & Work", "duration": "2.5h"},
      {"title": "Pipes & Cisterns", "duration": "2h"},
      {"title": "Time, Speed & Distance", "duration": "3h"},
      {"title": "Boats & Streams", "duration": "2h"},
      {"title": "Average", "duration": "2h"},
      {"title": "Mixture & Alligation", "duration": "2h"},
      {"title": "Mensuration (2D)", "duration": "3h"},
      {"title": "Mensuration (3D)", "duration": "3h"},
      {"title": "Algebra", "duration": "3h"},
      {"title": "Geometry", "duration": "3h"},
      {"title": "Trigonometry", "duration": "3.5h"},
      {"title": "Height & Distance", "duration": "2h"},
      {"title": "Data Interpretation", "duration": "3h"},
    ],


    "english": [
      {"title": "Reading Comprehension", "duration": "2.5h"},
      {"title": "Cloze Test", "duration": "2h"},
      {"title": "Error Spotting", "duration": "2h"},
      {"title": "Sentence Improvement", "duration": "2h"},
      {"title": "Fill in the Blanks", "duration": "1.5h"},
      {"title": "Active & Passive Voice", "duration": "2h"},
      {"title": "Direct & Indirect Speech", "duration": "2h"},
      {"title": "Tenses", "duration": "2.5h"},
      {"title": "Subject–Verb Agreement", "duration": "2h"},
      {"title": "Articles", "duration": "1.5h"},
      {"title": "Prepositions", "duration": "1.5h"},
      {"title": "Conjunctions", "duration": "1.5h"},
      {"title": "Synonyms & Antonyms", "duration": "2h"},
      {"title": "One Word Substitution", "duration": "1.5h"},
      {"title": "Idioms & Phrases", "duration": "2h"},
      {"title": "Para Jumbles", "duration": "2h"},
    ],


    "general_awareness": [
      {"title": "Indian History", "duration": "3h"},
      {"title": "Indian Geography", "duration": "3h"},
      {"title": "Indian Polity", "duration": "3h"},
      {"title": "Indian Economy", "duration": "3h"},
      {"title": "General Science", "duration": "3h"},
      {"title": "Physics (Basic)", "duration": "2h"},
      {"title": "Chemistry (Basic)", "duration": "2h"},
      {"title": "Biology (Basic)", "duration": "2h"},
      {"title": "Static GK", "duration": "2.5h"},
      {"title": "Sports", "duration": "1.5h"},
      {"title": "Awards & Honors", "duration": "1.5h"},
      {"title": "Books & Authors", "duration": "1.5h"},
      {"title": "Important Days", "duration": "1.5h"},
      {"title": "Government Schemes", "duration": "2h"},
    ],

    "computer_knowledge": [
      {"title": "Basics of Computer", "duration": "2h"},
      {"title": "Hardware & Software", "duration": "2h"},
      {"title": "Operating Systems", "duration": "2h"},
      {"title": "MS Word", "duration": "2h"},
      {"title": "MS Excel", "duration": "2.5h"},
      {"title": "MS PowerPoint", "duration": "1.5h"},
      {"title": "Internet Basics", "duration": "2h"},
      {"title": "Email & Networking", "duration": "2h"},
      {"title": "Cyber Security", "duration": "2h"},
      {"title": "Shortcut Keys", "duration": "1.5h"},
    ],


    "current_affairs": [
      {
        "title": "National Current Affairs",
        "duration": "2 hrs"
      },
      {
        "title": "International Current Affairs",
        "duration": "2 hrs"
      },
      {
        "title": "Government Schemes & Policies",
        "duration": "2 hrs"
      },
      {
        "title": "Appointments & Resignations",
        "duration": "1.5 hrs"
      },
      {
        "title": "Awards & Honours",
        "duration": "1.5 hrs"
      },
      {
        "title": "Sports Current Affairs",
        "duration": "1.5 hrs"
      },
      {
        "title": "Important Days & Themes",
        "duration": "1 hr"
      },
      {
        "title": "Books & Authors",
        "duration": "1 hr"
      },
      {
        "title": "Science & Tech in News (SSC Level)",
        "duration": "2 hrs"
      },
      {
        "title": "Economy in Current Affairs",
        "duration": "2 hrs"
      },
      {
        "title": "Defence & Security News",
        "duration": "1.5 hrs"
      },
      {
        "title": "Summits & Conferences",
        "duration": "1.5 hrs"
      },
      {
        "title": "Reports & Indexes",
        "duration": "2 hrs"
      },
      {
        "title": "Static GK linked with Current Affairs",
        "duration": "2 hrs"
      },
      {
        "title": "SSC Daily Current Affairs Practice",
        "duration": "1 hr"
      },
    ],
  },


  "banking": {

    // =========================
    // QUANTITATIVE APTITUDE
    // =========================
    "quantitative_aptitude": [
      {"title": "Number System (Types & Properties)", "duration": "3h"},
      {"title": "LCM & HCF", "duration": "2h"},
      {"title": "Simplification & Approximation", "duration": "3h"},
      {"title": "Surds & Indices", "duration": "2h"},
      {"title": "Ratio & Proportion", "duration": "2.5h"},
      {"title": "Percentage", "duration": "3h"},
      {"title": "Profit, Loss & Discount", "duration": "3h"},
      {"title": "Simple Interest", "duration": "2h"},
      {"title": "Compound Interest", "duration": "2.5h"},
      {"title": "Time & Work", "duration": "2.5h"},
      {"title": "Work & Wages", "duration": "2h"},
      {"title": "Pipes & Cisterns", "duration": "2h"},
      {"title": "Time, Speed & Distance", "duration": "3h"},
      {"title": "Boats & Streams", "duration": "2h"},
      {"title": "Average", "duration": "2h"},
      {"title": "Mixture & Alligation", "duration": "2.5h"},
      {"title": "Mensuration – 2D", "duration": "3h"},
      {"title": "Mensuration – 3D", "duration": "3h"},
      {"title": "Algebra (Basic Equations)", "duration": "2.5h"},
      {"title": "Quadratic Equations", "duration": "2.5h"},
      {"title": "Data Interpretation – Tables", "duration": "3h"},
      {"title": "Data Interpretation – Bar Graph", "duration": "3h"},
      {"title": "Data Interpretation – Line Graph", "duration": "3h"},
      {"title": "Data Interpretation – Pie Chart", "duration": "3h"},
      {"title": "Caselet DI", "duration": "3h"},
    ],

    // =========================
    // LOGICAL REASONING
    // =========================
    "logical_reasoning": [
      {"title": "Introduction to Reasoning", "duration": "1.5h"},
      {"title": "Alphabet & Number Series", "duration": "2h"},
      {"title": "Coding–Decoding", "duration": "2.5h"},
      {"title": "Inequality", "duration": "2h"},
      {"title": "Direction Sense Test", "duration": "2h"},
      {"title": "Blood Relations", "duration": "2h"},
      {"title": "Ranking & Order", "duration": "1.5h"},
      {"title": "Syllogism (Basic to Advanced)", "duration": "3h"},
      {"title": "Logical Venn Diagrams", "duration": "2h"},
      {"title": "Statement & Conclusion", "duration": "2h"},
      {"title": "Statement & Assumptions", "duration": "2h"},
      {"title": "Statement & Arguments", "duration": "2h"},
      {"title": "Cause & Effect", "duration": "2h"},
      {"title": "Seating Arrangement – Linear", "duration": "3h"},
      {"title": "Seating Arrangement – Circular", "duration": "3h"},
      {"title": "Floor Based Puzzles", "duration": "3h"},
      {"title": "Box & Variable Puzzles", "duration": "3h"},
      {"title": "Day & Month Puzzles", "duration": "2.5h"},
      {"title": "Input–Output Machine", "duration": "2.5h"},
      {"title": "Data Sufficiency", "duration": "2h"},
      {"title": "Logical Decision Making", "duration": "2h"},
    ],

    // =========================
    // ENGLISH
    // =========================
    "english": [
      {"title": "Reading Comprehension", "duration": "3h"},
      {"title": "Cloze Test", "duration": "2h"},
      {"title": "Error Spotting", "duration": "2.5h"},
      {"title": "Sentence Improvement", "duration": "2h"},
      {"title": "Fill in the Blanks", "duration": "2h"},
      {"title": "Para Jumbles", "duration": "2.5h"},
      {"title": "Sentence Rearrangement", "duration": "2h"},
      {"title": "Vocabulary – Synonyms & Antonyms", "duration": "2h"},
      {"title": "Idioms & Phrases", "duration": "2h"},
      {"title": "One Word Substitution", "duration": "2h"},
      {"title": "Active & Passive Voice", "duration": "2h"},
      {"title": "Direct & Indirect Speech", "duration": "2h"},
      {"title": "Tenses", "duration": "2.5h"},
      {"title": "Subject–Verb Agreement", "duration": "2h"},
      {"title": "Articles, Prepositions & Conjunctions", "duration": "2h"},
    ],

    // =========================
    // BANKING AWARENESS
    // =========================
    "banking_awareness": [
      {"title": "Introduction to Banking", "duration": "2h"},
      {"title": "History of Indian Banking", "duration": "2h"},
      {"title": "Types of Banks in India", "duration": "2.5h"},
      {"title": "RBI – Structure & Functions", "duration": "3h"},
      {"title": "Monetary Policy Tools", "duration": "3h"},
      {"title": "Financial Institutions in India", "duration": "2.5h"},
      {"title": "Types of Bank Accounts", "duration": "2h"},
      {"title": "Negotiable Instruments", "duration": "2h"},
      {"title": "Banking Terminologies", "duration": "2.5h"},
      {"title": "Loans & Advances", "duration": "2.5h"},
      {"title": "Priority Sector Lending", "duration": "2h"},
      {"title": "Digital Banking & Payment Systems", "duration": "3h"},
      {"title": "UPI, NEFT, RTGS, IMPS", "duration": "2.5h"},
      {"title": "Financial Inclusion", "duration": "2h"},
      {"title": "NPA & Basel Norms", "duration": "3h"},
      {"title": "Banking Reforms in India", "duration": "2.5h"},
      {"title": "NBFCs & Microfinance", "duration": "2h"},
    ],

    // =========================
    // COMPUTER KNOWLEDGE
    // =========================
    "computer_knowledge": [
      {"title": "Basics of Computers", "duration": "2h"},
      {"title": "Hardware Components", "duration": "2h"},
      {"title": "Software Types", "duration": "2h"},
      {"title": "Operating Systems", "duration": "2h"},
      {"title": "MS Word", "duration": "2h"},
      {"title": "MS Excel", "duration": "2.5h"},
      {"title": "MS PowerPoint", "duration": "1.5h"},
      {"title": "Internet & WWW", "duration": "2h"},
      {"title": "Email & Networking Basics", "duration": "2h"},
      {"title": "Cyber Security", "duration": "2h"},
      {"title": "Computer Shortcuts & Abbreviations", "duration": "1.5h"},
    ],

    // =========================
    // CURRENT AFFAIRS (BANKING)
    // =========================
    "current_affairs": [
      {"title": "Banking Current Affairs (Monthly)", "duration": "3h"},
      {"title": "RBI Circulars & Notifications", "duration": "2.5h"},
      {"title": "Bank Mergers & Acquisitions", "duration": "2h"},
      {"title": "New Banking Schemes", "duration": "2h"},
      {"title": "Financial & Economic News", "duration": "3h"},
      {"title": "Government Schemes (Banking Focus)", "duration": "2.5h"},
      {"title": "Appointments & Committees", "duration": "1.5h"},
      {"title": "Reports & Indexes (Economic)", "duration": "2h"},
      {"title": "Digital Banking in News", "duration": "2h"},
      {"title": "International Banking News", "duration": "2h"},
    ],


  },

  "railways": {

// ---------------- MATHEMATICS ----------------
    "mathematics": [
      {"title": "Number System", "duration": "3h"},
      {"title": "BODMAS", "duration": "2h"},
      {"title": "Decimals & Fractions", "duration": "2h"},
      {"title": "LCM & HCF", "duration": "2h"},
      {"title": "Ratio & Proportion", "duration": "2.5h"},
      {"title": "Percentage", "duration": "3h"},
      {"title": "Profit & Loss", "duration": "3h"},
      {"title": "Simple Interest", "duration": "2h"},
      {"title": "Compound Interest", "duration": "2.5h"},
      {"title": "Time & Work", "duration": "2.5h"},
      {"title": "Pipes & Cisterns", "duration": "2h"},
      {"title": "Time, Speed & Distance", "duration": "3h"},
      {"title": "Boats & Streams", "duration": "2h"},
      {"title": "Average", "duration": "2h"},
      {"title": "Mensuration (2D)", "duration": "3h"},
      {"title": "Mensuration (3D)", "duration": "3h"},
      {"title": "Algebra Basics", "duration": "2.5h"},
      {"title": "Geometry Basics", "duration": "2.5h"},
      {"title": "Trigonometry Basics", "duration": "3h"},
      {"title": "Data Interpretation", "duration": "3h"},
    ],

// ---------------- REASONING ----------------
    "reasoning": [
      {"title": "Analogies", "duration": "2h"},
      {"title": "Classification", "duration": "2h"},
      {"title": "Number Series", "duration": "2.5h"},
      {"title": "Alphabet Series", "duration": "2h"},
      {"title": "Coding & Decoding", "duration": "3h"},
      {"title": "Blood Relations", "duration": "2h"},
      {"title": "Direction Sense", "duration": "2h"},
      {"title": "Order & Ranking", "duration": "2h"},
      {"title": "Syllogism", "duration": "2.5h"},
      {"title": "Statement & Conclusion", "duration": "2.5h"},
      {"title": "Venn Diagrams", "duration": "2h"},
      {"title": "Seating Arrangement", "duration": "3h"},
      {"title": "Puzzles", "duration": "3h"},
      {"title": "Inequalities", "duration": "2h"},
      {"title": "Input Output", "duration": "2h"},
      {"title": "Mirror & Water Images", "duration": "2h"},
      {"title": "Paper Folding", "duration": "2h"},
    ],

// ---------------- GENERAL AWARENESS ----------------
    "general_awareness": [
      {"title": "Indian History", "duration": "3h"},
      {"title": "Indian Polity", "duration": "3h"},
      {"title": "Indian Economy", "duration": "3h"},
      {"title": "Indian Geography", "duration": "3h"},
      {"title": "World Geography", "duration": "2.5h"},
      {"title": "Indian Culture", "duration": "2h"},
      {"title": "Freedom Movement", "duration": "2.5h"},
      {"title": "Constitution of India", "duration": "3h"},
      {"title": "Static GK", "duration": "3h"},
      {"title": "Important Days & Events", "duration": "2h"},
      {"title": "Books & Authors", "duration": "2h"},
      {"title": "Sports & Awards", "duration": "2h"},
      {"title": "Railway GK", "duration": "2h"},
      {"title": "Government Schemes", "duration": "3h"},
      {"title": "Science & Tech (GK)", "duration": "2.5h"},
    ],

// ---------------- BASIC SCIENCE ----------------
    "basic_science": [
      {"title": "Motion", "duration": "2h"},
      {"title": "Force & Laws", "duration": "2h"},
      {"title": "Work, Power & Energy", "duration": "2.5h"},
      {"title": "Gravitation", "duration": "2h"},
      {"title": "Heat & Temperature", "duration": "2.5h"},
      {"title": "Sound", "duration": "2h"},
      {"title": "Light", "duration": "2h"},
      {"title": "Electricity", "duration": "3h"},
      {"title": "Magnetism", "duration": "2h"},
      {"title": "Matter & Its Nature", "duration": "2h"},
      {"title": "Atoms & Molecules", "duration": "2h"},
      {"title": "Acids, Bases & Salts", "duration": "2.5h"},
      {"title": "Metals & Non-Metals", "duration": "2.5h"},
      {"title": "Carbon & Compounds", "duration": "3h"},
      {"title": "Cell Structure", "duration": "2h"},
      {"title": "Human Digestive System", "duration": "2h"},
      {"title": "Respiratory System", "duration": "2h"},
      {"title": "Diseases & Prevention", "duration": "2h"},
      {"title": "Environment & Ecology", "duration": "2.5h"},
    ],

// ---------------- CURRENT AFFAIRS ----------------
    "current_affairs": [
      {"title": "National Current Affairs", "duration": "2h"},
      {"title": "International Current Affairs", "duration": "2h"},
      {"title": "Sports Current Affairs", "duration": "2h"},
      {"title": "Awards & Honours", "duration": "1.5h"},
      {"title": "Appointments", "duration": "1.5h"},
      {"title": "Government Schemes", "duration": "2.5h"},
      {"title": "Science & Technology News", "duration": "2h"},
      {"title": "Defence News", "duration": "1.5h"},
      {"title": "Railway Current Affairs", "duration": "2h"},
      {"title": "Economic Current Affairs", "duration": "2h"},
    ],
  },
  "tet": {

    // ---------------- CHILD DEVELOPMENT & PEDAGOGY ----------------
    "child_development_pedagogy": [
      {"title": "Growth & Development", "duration": "3h"},
      {"title": "Principles of Development", "duration": "2.5h"},
      {"title": "Stages of Child Development", "duration": "3h"},
      {"title": "Learning & Motivation", "duration": "3h"},
      {
        "title": "Theories of Learning (Piaget, Vygotsky, Kohlberg)",
        "duration": "4h"
      },
      {"title": "Intelligence & Creativity", "duration": "2.5h"},
      {"title": "Personality & Adjustment", "duration": "2.5h"},
      {"title": "Individual Differences", "duration": "2h"},
      {"title": "Inclusive Education", "duration": "3h"},
      {"title": "Children with Special Needs (CWSN)", "duration": "3h"},
      {"title": "Classroom Management", "duration": "2h"},
      {"title": "Assessment & Evaluation", "duration": "2.5h"},
      {"title": "Teacher–Learner Relationship", "duration": "2h"},
      {"title": "Guidance & Counselling", "duration": "2h"},
      {"title": "Educational Psychology", "duration": "3h"},
    ],

    // ---------------- TAMIL / REGIONAL LANGUAGE ----------------
    "regional_language": [
      {"title": "Tamil Language Pedagogy", "duration": "3h"},
      {"title": "Hindi Language Pedagogy", "duration": "3h"},
      {"title": "Telugu Language Pedagogy", "duration": "3h"},
      {"title": "Kannada Language Pedagogy", "duration": "3h"},
      {"title": "Malayalam Language Pedagogy", "duration": "3h"},
      {"title": "Marathi Language Pedagogy", "duration": "3h"},
      {"title": "Gujarati Language Pedagogy", "duration": "3h"},
      {"title": "Bengali Language Pedagogy", "duration": "3h"},
      {"title": "Odia Language Pedagogy", "duration": "3h"},
      {"title": "Punjabi Language Pedagogy", "duration": "3h"},
      {"title": "Urdu Language Pedagogy", "duration": "3h"},
      {"title": "Assamese Language Pedagogy", "duration": "3h"},
      {"title": "Konkani Language Pedagogy", "duration": "3h"},
      {"title": "Manipuri Language Pedagogy", "duration": "3h"},
      {"title": "Sanskrit Language Pedagogy", "duration": "3h"},
      {"title": "Language Learning Principles", "duration": "2.5h"},
      {"title": "Language Skills (LSRW)", "duration": "3h"},
      {"title": "Grammar Teaching Methods", "duration": "2.5h"},
      {"title": "Error Analysis", "duration": "2h"},
      {"title": "Remedial Teaching", "duration": "2h"},
    ],

    // ---------------- ENGLISH ----------------
    "english": [
      {"title": "English Language Pedagogy", "duration": "3h"},
      {"title": "Parts of Speech", "duration": "2h"},
      {"title": "Tenses", "duration": "2.5h"},
      {"title": "Voice (Active & Passive)", "duration": "2h"},
      {"title": "Direct & Indirect Speech", "duration": "2h"},
      {"title": "Articles & Determiners", "duration": "1.5h"},
      {"title": "Prepositions", "duration": "1.5h"},
      {"title": "Synonyms & Antonyms", "duration": "2h"},
      {"title": "Idioms & Phrases", "duration": "2h"},
      {"title": "Reading Comprehension", "duration": "3h"},
      {"title": "Vocabulary Development", "duration": "2.5h"},
      {"title": "Writing Skills", "duration": "2.5h"},
      {"title": "Teaching of Poetry & Prose", "duration": "3h"},
      {"title": "Language Acquisition", "duration": "2.5h"},
    ],

    // ---------------- MATHEMATICS ----------------
    "mathematics": [
      {"title": "Number System", "duration": "3h"},
      {"title": "Whole Numbers & Integers", "duration": "2.5h"},
      {"title": "Fractions & Decimals", "duration": "2.5h"},
      {"title": "Ratio & Proportion", "duration": "2.5h"},
      {"title": "Percentage", "duration": "2.5h"},
      {"title": "Basic Algebra", "duration": "3h"},
      {"title": "Linear Equations", "duration": "2.5h"},
      {"title": "Geometry Basics", "duration": "3h"},
      {"title": "Triangles & Circles", "duration": "3h"},
      {"title": "Mensuration", "duration": "3h"},
      {"title": "Data Handling", "duration": "2.5h"},
      {"title": "Mathematics Pedagogy", "duration": "3h"},
      {"title": "Problem Solving Strategies", "duration": "2.5h"},
      {"title": "Error Analysis in Maths", "duration": "2h"},
    ],

    // ---------------- ENVIRONMENTAL STUDIES ----------------
    "environmental_studies": [
      {"title": "Family & Relationships", "duration": "2h"},
      {"title": "Food & Nutrition", "duration": "2h"},
      {"title": "Shelter & Clothing", "duration": "2h"},
      {"title": "Water Resources", "duration": "2.5h"},
      {"title": "Plants & Animals", "duration": "3h"},
      {"title": "Human Body & Health", "duration": "3h"},
      {"title": "Transport & Communication", "duration": "2h"},
      {"title": "Our Earth", "duration": "3h"},
      {"title": "Natural Resources", "duration": "3h"},
      {"title": "Environmental Pollution", "duration": "2.5h"},
      {"title": "Disaster Management", "duration": "2h"},
      {"title": "Social & Cultural Life", "duration": "2.5h"},
      {"title": "Teaching EVS", "duration": "3h"},
      {"title": "EVS Pedagogy", "duration": "3h"},
    ],
  },

  "police": {

    // ---------------- GENERAL STUDIES ----------------
    "general_studies": [
      {"title": "Indian History – Ancient India", "duration": "3h"},
      {"title": "Indian History – Medieval India", "duration": "3h"},
      {"title": "Indian History – Modern India", "duration": "4h"},
      {"title": "Indian National Movement", "duration": "4h"},
      {"title": "Indian Constitution – Basics", "duration": "3h"},
      {"title": "Fundamental Rights & Duties", "duration": "2.5h"},
      {"title": "Directive Principles of State Policy", "duration": "2h"},
      {"title": "Indian Polity – Parliament & Judiciary", "duration": "3h"},
      {"title": "Indian Geography – Physical", "duration": "3h"},
      {"title": "Indian Geography – Economic", "duration": "3h"},
      {"title": "Indian Geography – Human", "duration": "2.5h"},
      {"title": "Indian Economy – Basics", "duration": "3h"},
      {"title": "Planning & Economic Development", "duration": "2.5h"},
      {"title": "Science & Technology – Basics", "duration": "3h"},
      {"title": "Physics (Daily Life Applications)", "duration": "2.5h"},
      {"title": "Chemistry (Everyday Chemistry)", "duration": "2.5h"},
      {"title": "Biology – Human Body", "duration": "3h"},
      {"title": "Environment & Ecology", "duration": "2.5h"},
      {"title": "Current Affairs – National", "duration": "3h"},
      {"title": "Current Affairs – International", "duration": "3h"},
      {"title": "Sports, Awards & Honours", "duration": "2h"},
    ],

    // ---------------- REASONING ----------------
    "reasoning": [
      {"title": "Analogy", "duration": "2h"},
      {"title": "Classification", "duration": "2h"},
      {"title": "Series (Number & Alphabet)", "duration": "2.5h"},
      {"title": "Coding & Decoding", "duration": "2.5h"},
      {"title": "Blood Relations", "duration": "2h"},
      {"title": "Direction Sense Test", "duration": "2h"},
      {"title": "Order & Ranking", "duration": "2h"},
      {"title": "Syllogism", "duration": "2.5h"},
      {"title": "Venn Diagrams", "duration": "2h"},
      {"title": "Logical Venn Problems", "duration": "2h"},
      {"title": "Statement & Conclusion", "duration": "2.5h"},
      {"title": "Statement & Assumptions", "duration": "2.5h"},
      {"title": "Cause & Effect", "duration": "2h"},
      {"title": "Non-Verbal Reasoning", "duration": "3h"},
      {"title": "Mirror & Water Images", "duration": "2h"},
      {"title": "Paper Folding & Cutting", "duration": "2h"},
    ],

    // ---------------- LAW BASICS ----------------
    "law_basics": [
      {"title": "Indian Penal Code (IPC) – Introduction", "duration": "3h"},
      {"title": "IPC – Offences Against Human Body", "duration": "3h"},
      {"title": "IPC – Property Offences", "duration": "3h"},
      {"title": "IPC – Punishments", "duration": "2.5h"},
      {"title": "Criminal Procedure Code (CrPC) – Basics", "duration": "3h"},
      {"title": "CrPC – Arrest, FIR & Investigation", "duration": "3h"},
      {"title": "CrPC – Trial Procedure", "duration": "2.5h"},
      {"title": "Indian Evidence Act – Basics", "duration": "3h"},
      {"title": "Types of Evidence", "duration": "2.5h"},
      {"title": "Witness & Confession", "duration": "2h"},
      {"title": "Cyber Crime Laws", "duration": "2h"},
      {"title": "Traffic Laws & Motor Vehicles Act", "duration": "2h"},
      {"title": "Women & Child Protection Laws", "duration": "2.5h"},
      {"title": "SC/ST Prevention of Atrocities Act", "duration": "2h"},
      {"title": "Police Duties & Powers", "duration": "2.5h"},
    ],

    // ---------------- PHYSICAL TEST GUIDANCE ----------------
    "physical_test_guidance": [
      {
        "title": "Police Physical Standards (Height, Chest, Weight)",
        "duration": "2h"
      },
      {"title": "Endurance Training Basics", "duration": "2h"},
      {"title": "Running Training (1600m / 800m)", "duration": "2.5h"},
      {"title": "Sprint Training (100m / 200m)", "duration": "2h"},
      {"title": "Long Jump Technique", "duration": "2h"},
      {"title": "High Jump Technique", "duration": "2h"},
      {"title": "Rope Climbing Training", "duration": "2h"},
      {"title": "Push-ups & Sit-ups Training", "duration": "2h"},
      {"title": "Flexibility & Stretching", "duration": "1.5h"},
      {"title": "Diet & Nutrition for Police Exam", "duration": "2h"},
      {"title": "Injury Prevention & Recovery", "duration": "1.5h"},
      {"title": "Mental Toughness & Discipline", "duration": "2h"},
      {"title": "Daily Physical Training Plan", "duration": "2.5h"},
      {"title": "Medical Test Preparation", "duration": "1.5h"},
    ],
  },

  "rbi_grade_b": {

// ================= QUANTITATIVE APTITUDE =================
    "quantitative_aptitude": [
      {"title": "Number System", "duration": "3h"},
      {"title": "Simplification & Approximation", "duration": "3h"},
      {"title": "HCF & LCM", "duration": "2h"},
      {"title": "Ratio & Proportion", "duration": "3h"},
      {"title": "Percentage", "duration": "3h"},
      {"title": "Profit & Loss", "duration": "3h"},
      {"title": "Simple Interest", "duration": "2.5h"},
      {"title": "Compound Interest", "duration": "2.5h"},
      {"title": "Average", "duration": "2h"},
      {"title": "Time & Work", "duration": "3h"},
      {"title": "Pipes & Cisterns", "duration": "2.5h"},
      {"title": "Time, Speed & Distance", "duration": "3h"},
      {"title": "Boats & Streams", "duration": "2.5h"},
      {"title": "Mensuration – 2D", "duration": "3h"},
      {"title": "Mensuration – 3D", "duration": "3h"},
      {"title": "Data Interpretation – Tables", "duration": "3h"},
      {"title": "Data Interpretation – Bar Graph", "duration": "3h"},
      {"title": "Data Interpretation – Line Graph", "duration": "3h"},
      {"title": "Data Interpretation – Pie Chart", "duration": "3h"},
      {"title": "Caselet DI", "duration": "3h"},
    ],

// ================= REASONING =================
    "reasoning": [
      {"title": "Analogy", "duration": "2.5h"},
      {"title": "Classification", "duration": "2.5h"},
      {"title": "Series – Number & Alphabet", "duration": "3h"},
      {"title": "Coding & Decoding", "duration": "3h"},
      {"title": "Blood Relations", "duration": "2.5h"},
      {"title": "Direction Sense", "duration": "2.5h"},
      {"title": "Order & Ranking", "duration": "2.5h"},
      {"title": "Seating Arrangement – Linear", "duration": "3h"},
      {"title": "Seating Arrangement – Circular", "duration": "3h"},
      {"title": "Puzzle – Floor & Box", "duration": "3h"},
      {"title": "Syllogism", "duration": "2.5h"},
      {"title": "Inequality", "duration": "2.5h"},
      {"title": "Input Output", "duration": "3h"},
      {"title": "Statement & Conclusion", "duration": "2.5h"},
      {"title": "Statement & Assumption", "duration": "2.5h"},
      {"title": "Data Sufficiency", "duration": "3h"},
    ],

// ================= ENGLISH =================
    "english": [
      {"title": "Reading Comprehension", "duration": "4h"},
      {"title": "Vocabulary Building", "duration": "3h"},
      {"title": "Synonyms & Antonyms", "duration": "2.5h"},
      {"title": "One Word Substitution", "duration": "2.5h"},
      {"title": "Idioms & Phrases", "duration": "2.5h"},
      {"title": "Spotting Errors", "duration": "3h"},
      {"title": "Sentence Improvement", "duration": "3h"},
      {"title": "Fill in the Blanks", "duration": "2.5h"},
      {"title": "Cloze Test", "duration": "3h"},
      {"title": "Para Jumbles", "duration": "3h"},
      {"title": "Essay Writing (Phase 2)", "duration": "4h"},
      {"title": "Precis Writing (Phase 2)", "duration": "3h"},
      {"title": "Reading Comprehension – Descriptive", "duration": "4h"},
    ],

// ================= ECONOMICS & BANKING =================
    "economics_banking": [
      {"title": "Indian Economy – Basic Concepts", "duration": "4h"},
      {"title": "National Income & GDP", "duration": "3h"},
      {"title": "Inflation – Types & Causes", "duration": "3h"},
      {"title": "Monetary Policy of RBI", "duration": "4h"},
      {"title": "Fiscal Policy", "duration": "3h"},
      {"title": "Financial Markets in India", "duration": "3h"},
      {"title": "Banking System in India", "duration": "4h"},
      {"title": "Role & Functions of RBI", "duration": "4h"},
      {"title": "Money Supply & Credit", "duration": "3h"},
      {"title": "Inflation Targeting", "duration": "3h"},
      {"title": "Basel Norms", "duration": "3h"},
      {"title": "Non Performing Assets (NPA)", "duration": "3h"},
      {"title": "Financial Inclusion", "duration": "3h"},
      {"title": "Digital Banking & Payments", "duration": "3h"},
      {"title": "Capital Market & Debt Market", "duration": "3h"},
      {"title": "Economic Reforms in India", "duration": "4h"},
      {
        "title": "International Financial Institutions (IMF, WB)",
        "duration": "3h"
      },
      {"title": "Government Schemes (Economy Based)", "duration": "3h"},
    ],

// ================= CURRENT AFFAIRS =================
    "current_affairs": [
      {"title": "Current Affairs – Economy", "duration": "4h"},
      {"title": "Current Affairs – Banking & Finance", "duration": "4h"},
      {"title": "Current Affairs – RBI Circulars", "duration": "3h"},
      {"title": "Current Affairs – Government Schemes", "duration": "3h"},
      {"title": "Current Affairs – International Economy", "duration": "3h"},
      {"title": "Current Affairs – Reports & Indices", "duration": "3h"},
      {"title": "Current Affairs – Budget & Economic Survey", "duration": "4h"},
      {"title": "Current Affairs – Appointments & Awards", "duration": "2.5h"},
      {
        "title": "Current Affairs – National & International News",
        "duration": "3h"},
    ],
  },
  "cat": {

    // ================= QUANTITATIVE APTITUDE =================
    "quantitative_aptitude": [
      {"title": "Number System – Properties & Types", "duration": "3h"},
      {"title": "HCF & LCM", "duration": "2h"},
      {"title": "Divisibility Rules", "duration": "2h"},
      {"title": "Simplification & Approximation", "duration": "2.5h"},
      {"title": "Surds & Indices", "duration": "2h"},
      {"title": "Percentages", "duration": "3h"},
      {"title": "Profit, Loss & Discount", "duration": "3h"},
      {"title": "Ratio & Proportion", "duration": "2.5h"},
      {"title": "Averages", "duration": "2h"},
      {"title": "Mixtures & Alligation", "duration": "2.5h"},
      {"title": "Simple Interest", "duration": "2h"},
      {"title": "Compound Interest", "duration": "2.5h"},
      {"title": "Time & Work", "duration": "3h"},
      {"title": "Pipes & Cisterns", "duration": "2h"},
      {"title": "Time, Speed & Distance", "duration": "3h"},
      {"title": "Boats & Streams", "duration": "2h"},
      {"title": "Linear Equations", "duration": "2.5h"},
      {"title": "Quadratic Equations", "duration": "3h"},
      {"title": "Inequalities", "duration": "2h"},
      {"title": "Functions & Graphs", "duration": "3h"},
      {"title": "Logarithms", "duration": "2h"},
      {"title": "Progressions (AP, GP, HP)", "duration": "3h"},
      {"title": "Permutations & Combinations", "duration": "3h"},
      {"title": "Probability", "duration": "3h"},
      {"title": "Set Theory", "duration": "2.5h"},
      {"title": "Mensuration – 2D Geometry", "duration": "3h"},
      {"title": "Mensuration – 3D Geometry", "duration": "3h"},
      {"title": "Coordinate Geometry", "duration": "3h"},
      {"title": "Trigonometry Basics", "duration": "2.5h"},
      {"title": "Advanced CAT Arithmetic Practice", "duration": "4h"},
    ],

    // ================= LOGICAL REASONING & DATA INTERPRETATION =================
    "logical_reasoning_di": [
      {"title": "Introduction to Logical Reasoning", "duration": "2h"},
      {"title": "Arrangements – Linear", "duration": "3h"},
      {"title": "Arrangements – Circular", "duration": "3h"},
      {"title": "Arrangements – Complex", "duration": "3h"},
      {"title": "Selection & Distribution Puzzles", "duration": "3h"},
      {"title": "Binary Logic", "duration": "2.5h"},
      {"title": "Blood Relations", "duration": "2h"},
      {"title": "Direction Sense", "duration": "2h"},
      {"title": "Venn Diagrams", "duration": "2.5h"},
      {"title": "Syllogisms", "duration": "2.5h"},
      {"title": "Logical Games & Tournaments", "duration": "3h"},
      {"title": "Data Interpretation – Tables", "duration": "3h"},
      {"title": "Data Interpretation – Bar Graphs", "duration": "3h"},
      {"title": "Data Interpretation – Line Graphs", "duration": "3h"},
      {"title": "Data Interpretation – Pie Charts", "duration": "3h"},
      {"title": "Caselet DI", "duration": "3h"},
      {"title": "Mixed Graphs", "duration": "3h"},
      {"title": "Quant-based LR Sets", "duration": "3h"},
      {"title": "Advanced CAT LRDI Sets", "duration": "4h"},
    ],

    // ================= VERBAL ABILITY (ENGLISH) =================
    "verbal_ability": [
      {"title": "Reading Comprehension – Basics", "duration": "3h"},
      {"title": "RC – Fact Based Questions", "duration": "3h"},
      {"title": "RC – Inference Based Questions", "duration": "3h"},
      {"title": "RC – Tone & Purpose", "duration": "2.5h"},
      {"title": "RC – Philosophy & Abstract Passages", "duration": "3h"},
      {"title": "Vocabulary Building", "duration": "3h"},
      {"title": "Synonyms & Antonyms", "duration": "2h"},
      {"title": "Idioms & Phrases", "duration": "2h"},
      {"title": "Sentence Correction", "duration": "2.5h"},
      {"title": "Grammar Fundamentals", "duration": "3h"},
      {"title": "Para Jumbles", "duration": "3h"},
      {"title": "Para Completion", "duration": "2.5h"},
      {"title": "Odd Sentence Out", "duration": "2h"},
      {"title": "Sentence Summary", "duration": "2.5h"},
      {"title": "Critical Reasoning – Assumptions", "duration": "3h"},
      {"title": "Critical Reasoning – Strengthen & Weaken", "duration": "3h"},
      {"title": "CAT Level Verbal Practice", "duration": "4h"},
    ],

    // ================= BUSINESS AWARENESS =================
    "business_awareness": [
      {"title": "Introduction to Business & Management", "duration": "2h"},
      {"title": "Basics of Economics", "duration": "2.5h"},
      {"title": "Microeconomics – Demand & Supply", "duration": "3h"},
      {"title": "Macroeconomics – Inflation & GDP", "duration": "3h"},
      {"title": "Indian Economy Overview", "duration": "3h"},
      {"title": "Banking System in India", "duration": "3h"},
      {"title": "Financial Markets & Instruments", "duration": "3h"},
      {"title": "Accounting Fundamentals", "duration": "3h"},
      {"title": "Profit & Loss Statements", "duration": "2.5h"},
      {"title": "Balance Sheet Basics", "duration": "2.5h"},
      {"title": "Marketing Management", "duration": "3h"},
      {"title": "Human Resource Management", "duration": "2.5h"},
      {"title": "Operations Management", "duration": "2.5h"},
      {"title": "Business Strategy Basics", "duration": "3h"},
      {"title": "Corporate Governance", "duration": "2h"},
      {"title": "Current Business & Economic Affairs", "duration": "3h"},
    ],
  },

  "army": {

    // ================= GENERAL KNOWLEDGE =================
    "general_knowledge": [
      {"title": "Indian History – Ancient", "duration": "2h"},
      {"title": "Indian History – Medieval", "duration": "2h"},
      {"title": "Indian History – Modern Freedom Struggle", "duration": "3h"},
      {"title": "Indian Constitution – Basics", "duration": "2.5h"},
      {"title": "Fundamental Rights & Duties", "duration": "2h"},
      {"title": "Indian Parliament & Judiciary", "duration": "2h"},
      {"title": "Indian Geography – Physical", "duration": "2.5h"},
      {"title": "Indian Geography – Rivers & Mountains", "duration": "2h"},
      {"title": "Indian Geography – Climate & Soil", "duration": "2h"},
      {"title": "Indian Economy – Basics", "duration": "2.5h"},
      {"title": "Defence Forces of India", "duration": "2h"},
      {"title": "Indian Army – Structure & Ranks", "duration": "2h"},
      {"title": "Indian Navy – Commands & Ships", "duration": "2h"},
      {"title": "Indian Air Force – Aircraft & Commands", "duration": "2h"},
      {"title": "Important National Days & Symbols", "duration": "1.5h"},
      {"title": "Awards & Honours", "duration": "1.5h"},
      {"title": "Sports & Games", "duration": "1.5h"},
      {"title": "Important Books & Authors", "duration": "1.5h"},
      {"title": "Current Affairs – National", "duration": "3h"},
      {"title": "Current Affairs – International", "duration": "3h"},
    ],

    // ================= MATHEMATICS =================
    "mathematics": [
      {"title": "Number System", "duration": "2.5h"},
      {"title": "Simplification", "duration": "2h"},
      {"title": "HCF & LCM", "duration": "2h"},
      {"title": "Decimals & Fractions", "duration": "2h"},
      {"title": "Ratio & Proportion", "duration": "2.5h"},
      {"title": "Percentage", "duration": "2.5h"},
      {"title": "Profit & Loss", "duration": "2.5h"},
      {"title": "Simple Interest", "duration": "2h"},
      {"title": "Compound Interest", "duration": "2h"},
      {"title": "Average", "duration": "2h"},
      {"title": "Time & Work", "duration": "2.5h"},
      {"title": "Pipes & Cisterns", "duration": "2h"},
      {"title": "Time, Speed & Distance", "duration": "2.5h"},
      {"title": "Boats & Streams", "duration": "2h"},
      {"title": "Mensuration – 2D", "duration": "2.5h"},
      {"title": "Mensuration – 3D", "duration": "2.5h"},
      {"title": "Algebra – Basic Equations", "duration": "2h"},
      {"title": "Trigonometry – Basics", "duration": "2.5h"},
      {"title": "Statistics", "duration": "2h"},
    ],

    // ================= REASONING =================
    "reasoning": [
      {"title": "Analogy", "duration": "2h"},
      {"title": "Classification", "duration": "2h"},
      {"title": "Series – Number & Alphabet", "duration": "2h"},
      {"title": "Coding & Decoding", "duration": "2.5h"},
      {"title": "Blood Relations", "duration": "2h"},
      {"title": "Direction Sense", "duration": "2h"},
      {"title": "Venn Diagrams", "duration": "2h"},
      {"title": "Syllogism", "duration": "2h"},
      {"title": "Seating Arrangement", "duration": "2.5h"},
      {"title": "Puzzle Test", "duration": "2.5h"},
      {"title": "Mathematical Operations", "duration": "2h"},
      {"title": "Statement & Conclusion", "duration": "2h"},
      {"title": "Statement & Assumption", "duration": "2h"},
      {"title": "Non-Verbal Reasoning", "duration": "2.5h"},
    ],

    // ================= ENGLISH =================
    "english": [
      {"title": "Vocabulary Building", "duration": "2.5h"},
      {"title": "Synonyms & Antonyms", "duration": "2h"},
      {"title": "One Word Substitution", "duration": "2h"},
      {"title": "Idioms & Phrases", "duration": "2h"},
      {"title": "Spelling Errors", "duration": "2h"},
      {"title": "Spotting Errors", "duration": "2.5h"},
      {"title": "Sentence Improvement", "duration": "2h"},
      {"title": "Fill in the Blanks", "duration": "2h"},
      {"title": "Active & Passive Voice", "duration": "2.5h"},
      {"title": "Direct & Indirect Speech", "duration": "2.5h"},
      {"title": "Reading Comprehension", "duration": "3h"},
      {"title": "Cloze Test", "duration": "2h"},
      {"title": "Para Jumbles", "duration": "2h"},
    ],

    // ================= SCIENCE (BASIC) =================
    "science_basic": [
      {"title": "Physics – Motion & Laws", "duration": "2.5h"},
      {"title": "Physics – Work, Energy & Power", "duration": "2.5h"},
      {"title": "Physics – Heat & Temperature", "duration": "2h"},
      {"title": "Physics – Light & Sound", "duration": "2h"},
      {"title": "Physics – Electricity & Magnetism", "duration": "2.5h"},
      {"title": "Chemistry – Matter & Its States", "duration": "2h"},
      {"title": "Chemistry – Elements & Compounds", "duration": "2h"},
      {"title": "Chemistry – Acids, Bases & Salts", "duration": "2h"},
      {"title": "Chemistry – Metals & Non-Metals", "duration": "2.5h"},
      {"title": "Biology – Cell Structure", "duration": "2h"},
      {"title": "Biology – Human Body Systems", "duration": "2.5h"},
      {"title": "Biology – Nutrition & Diseases", "duration": "2h"},
      {"title": "Environmental Science", "duration": "2h"},
    ],
  },
  "state_psc": {

    // ================= GENERAL STUDIES =================
    "general_studies": [
      {"title": "Indian National Movement", "duration": "3h"},
      {"title": "Indian Culture & Heritage", "duration": "3h"},
      {"title": "Indian Geography – Physical", "duration": "3h"},
      {"title": "Indian Geography – Human & Economic", "duration": "3h"},
      {"title": "Indian Economy – Basic Concepts", "duration": "3h"},
      {"title": "Indian Polity – Constitution Basics", "duration": "3h"},
      {"title": "Science & Technology – General", "duration": "3h"},
      {"title": "Environmental Science & Ecology", "duration": "3h"},
      {"title": "Disaster Management", "duration": "2.5h"},
      {"title": "Ethics, Integrity & Aptitude", "duration": "3h"},
      {"title": "General Mental Ability", "duration": "3h"},
    ],

    // ================= POLITY =================
    "polity": [
      {"title": "Indian Constitution – Features", "duration": "3h"},
      {"title": "Fundamental Rights", "duration": "3h"},
      {"title": "Fundamental Duties", "duration": "2h"},
      {"title": "Directive Principles of State Policy", "duration": "3h"},
      {"title": "Union Government – President & PM", "duration": "3h"},
      {"title": "Parliament – Lok Sabha & Rajya Sabha", "duration": "3h"},
      {"title": "Judiciary – Supreme Court & High Court", "duration": "3h"},
      {"title": "State Government – Governor & CM", "duration": "3h"},
      {"title": "State Legislature", "duration": "3h"},
      {"title": "Local Self Government – Panchayats", "duration": "2.5h"},
      {"title": "Municipal Administration", "duration": "2.5h"},
      {"title": "Constitutional Bodies", "duration": "3h"},
      {"title": "Non-Constitutional Bodies", "duration": "2.5h"},
      {"title": "Elections & Electoral Reforms", "duration": "2.5h"},
    ],

    // ================= GEOGRAPHY OF STATE =================
    "state_geography": [
      {"title": "Location & Physical Features of State", "duration": "3h"},
      {"title": "Physiographic Divisions", "duration": "3h"},
      {"title": "Climate & Rainfall", "duration": "2.5h"},
      {"title": "Rivers & Drainage System", "duration": "3h"},
      {"title": "Soil Types", "duration": "2.5h"},
      {"title": "Natural Vegetation", "duration": "2.5h"},
      {"title": "Wildlife & Biosphere Reserves", "duration": "3h"},
      {"title": "Mineral Resources", "duration": "2.5h"},
      {"title": "Agriculture & Cropping Pattern", "duration": "3h"},
      {"title": "Irrigation Projects", "duration": "2.5h"},
      {"title": "Industries of State", "duration": "3h"},
      {"title": "Transport & Communication", "duration": "2.5h"},
      {"title": "Urbanization & Population", "duration": "2.5h"},
    ],

    // ================= ECONOMY OF STATE =================
    "state_economy": [
      {"title": "State Economy – Overview", "duration": "3h"},
      {"title": "Gross State Domestic Product (GSDP)", "duration": "2.5h"},
      {"title": "Agricultural Economy of State", "duration": "3h"},
      {"title": "Industrial Development", "duration": "3h"},
      {"title": "Service Sector Growth", "duration": "2.5h"},
      {"title": "Poverty & Unemployment", "duration": "2.5h"},
      {"title": "State Budget & Finance", "duration": "3h"},
      {"title": "State Planning & Development Schemes", "duration": "3h"},
      {"title": "Cooperative Movement", "duration": "2.5h"},
      {"title": "Public Distribution System (PDS)", "duration": "2.5h"},
      {"title": "Social Welfare Schemes", "duration": "3h"},
      {"title": "Human Development Index of State", "duration": "2.5h"},
    ],

    // ================= HISTORY OF STATE =================
    "state_history": [
      {"title": "Prehistoric Period of State", "duration": "2.5h"},
      {"title": "Ancient History of State", "duration": "3h"},
      {"title": "Medieval History of State", "duration": "3h"},
      {"title": "Modern History of State", "duration": "3h"},
      {"title": "Freedom Movement in State", "duration": "3h"},
      {"title": "Social Reform Movements", "duration": "3h"},
      {"title": "Language, Literature & Culture", "duration": "3h"},
      {"title": "Art, Architecture & Temples", "duration": "3h"},
      {"title": "Important Historical Personalities", "duration": "2.5h"},
      {"title": "Role of State in National Movement", "duration": "3h"},
    ],

    // ================= CURRENT AFFAIRS =================
    "current_affairs": [
      {"title": "Current Affairs – State Issues", "duration": "3h"},
      {"title": "Current Affairs – State Government Schemes", "duration": "3h"},
      {"title": "Current Affairs – State Budget", "duration": "2.5h"},
      {"title": "Current Affairs – Appointments", "duration": "2h"},
      {"title": "Current Affairs – Awards & Honours", "duration": "2h"},
      {"title": "Current Affairs – Sports", "duration": "2h"},
      {"title": "Current Affairs – Environment & Ecology", "duration": "2.5h"},
      {"title": "Current Affairs – Economy & Planning", "duration": "3h"},
      {"title": "Current Affairs – National & International", "duration": "3h"},
    ],
  },
};