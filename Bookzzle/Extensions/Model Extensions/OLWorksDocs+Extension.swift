//
// Bookzzle
// 
// Created by The Architect on 7/27/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

extension OLWorksDocs {
    
    // MARK: - PREVIEW SAMPLES
    static var sample: [OLWorksDocs] {
        [
            OLWorksDocs(
                key: "/works/OL471565W",
                title: "And Then There Were None",
                firstPublishYear: Optional(1939),
                language: Optional(["jpn", "vie", "fre", "ger", "fin", "spa", "ita", "por", "hun", "dut", "rus", "chi", "pol", "eng", "gre"]),
                firstSentence: Optional(["In the corner of a first-class smoking carriage, Mr. Justice Wargrave, lately retired from the bench, puffed at a cigar and ran an interested eye through the political news in the Times.", "IN THE CORNER of a first-class smoking carriage, Mr. Justice Wargrave, lately retired from the bench, puffed at a cigar and ran an interested eye through the political news in the Times."]),
                numberOfPagesMedian: Optional(231),
                authorKey: Optional(["OL27695A"]),
                authorName: Optional(["Agatha Christie"]),
                coverI: Optional(11172296),
                coverEditionKey: Optional("OL32520899M"),
                ddc: Optional(["823.912", "823.9", "828.912"]),
                isbn: Optional(["9780425129586", "9780007234523", "9783125400030", "9780312979478", "9780062484390", "0613354478", "9788804307679", "1906141010", "9780671424572", "9788427298033", "9780812415056", "0671488953", "1572704497", "9752124399", "067170608X", "9780671801519", "8324589465", "3125400031", "8804307676", "1408231832", "9781572704497", "9780671803513", "9780008328924", "9788324589463", "9781572702509", "0312979479", "9789752126169", "9786070744877", "9781559277341", "9780671814403", "9798476146292", "9780008392949", "9788482885865", "0671447254", "9780671481599", "8427285345", "1520571348", "9780671704667", "9780671499495", "0008328927", "0671704664", "9780671775810", "9788466410038", "9507428127", "9780007525317", "9871144482", "8804507594", "0007525311", "8804357525", "9780553350005", "9789507840005", "9780807230336", "006226589X", "9780008123208", "1606869426", "9782253241782", "9780795308925", "9780671417550", "0671481592", "5699930353", "0795308922", "0671433784", "0062081527", "9788466403733", "9781405689854", "0708914845", "9780062081520", "0007275323", "9780060820275", "9781461139362", "3502519374", "000723452X", "8478712089", "0060736313", "9780061739255", "9780060746834", "0060746831", "9780007136834", "9788327161130", "9785227018144", "0060736321", "9789854280509", "9789075388411", "9789573249955", "0062490370", "8466403736", "0008255466", "6041015687", "9781906141011", "9780399150180", "2702424694", "0425129586", "9788804507598", "9781408467602", "9788447354108", "9788427285347", "9780671831387", "9788804357520", "9780816196418", "9854280500", "832716113X", "9780060736323", "9780061155710", "9789630708036", "9780671467210", "3125400228", "8492966548", "842729803X", "9780007275328", "0671467212", "9780007282319", "0061739251", "9782010009105", "5227018146", "9780396085720", "9630708035", "1572702516", "9783125400221", "0881032565", "0606218181", "1461139368", "9782013224024", "8490561346", "9782378282691", "9781568497365", "1568497369", "9780007525300", "0671424572", "9782702435823", "8327150367", "1408231840", "0062073478", "0816196419", "9780002318358", "144480295X", "9507840001", "2378282699", "9780002448079", "9783502519379", "9780671552220", "9781572702516", "9780062265890", "9573249952", "067141755X", "9782702424698", "0007136838", "8447354105", "9780671441364", "9788525045294", "9783502111108", "284634003X", "0671441361", "9798482998526", "9781804223079", "0312330871", "9752126162", "201000910X", "7020065392", "9781408231838", "0007115512", "9798635849668", "0671466062", "9781520571348", "6559870332", "9788478712083", "1572702508", "9781405032728", "4151300805", "9780671460747", "0002318350", "9787513322331", "0062073486", "9788327150363", "1804223077", "8525045292", "9782702410042", "9780006117278", "3455650716", "9789752124394", "0062484397", "9786041015685", "0060820276", "1405689854", "9782070500802", "9780671754013", "9780060736316", "9780671466060", "0671831380", "9780062073488", "9781606869420", "9782253003960", "2702410049", "0671754017", "9789507428128", "9504916090", "0002320770", "006073633X", "9784151300806", "7513322333", "9788804616986", "9785699930357", "2702478581", "0671552228", "9781444802955", "0945353642", "2013220626", "0396085725", "1899888837", "9782013220620", "0061155713", "1559277343", "9788498678925", "9780006165408", "0007525303", "9780007422135", "9783455650716", "9788490561348", "9780671488956", "9780060736330", "0812415051", "0008123209", "0006117279", "0807230332", "0671775812", "9782012096318", "2253003964", "9781899888832", "9780329251345", "2013224028", "000742213X", "9075388411", "201209631X", "607074487X", "9789504916093", "9780708914847", "0671814400", "0329251341", "9780613354479", "1405032723", "9780062325549", "9780671447250", "9789871144488", "0671803514", "9780007115518", "9787020065394", "8482885863", "9780002320771", "2070500802", "9780062073471", "2253241784", "3502517673", "0006165400", "8466410031", "0671460749", "0671826832", "9780881032567", "0008392943", "2702435823", "9780062490377", "9780312330873", "0671801511", "0002448076", "8427200153", "1408467607", "9781408231845", "9788492966547", "9782846340038", "9788467066623", "9786559870332", "9780945353645", "0007282311", "8498678927", "9783502517672", "9780008255466", "006232554X", "9782702478585", "9780671826833", "0399150188", "9798695338904", "9780671706081", "9780606218184", "0553350005", "8467066628", "9788427200159", "9798721783623", "3502111103", "8804616989", "9780671433789", "0671499491"]),
                lccn: Optional(["89171858", "78108821", "84072786", "40006132", "80451141"]),
                editionCount: Optional(185),
                editionKey: Optional(["OL58698112M", "OL58558644M", "OL57899505M", "OL50453605M", "OL49808404M", "OL49279818M", "OL48108914M", "OL51007761M", "OL50567190M", "OL50564888M", "OL9515534M", "OL49205972M", "OL47677038M", "OL38628938M", "OL47102636M", "OL47102649M", "OL47097908M", "OL47232631M", "OL31895934M", "OL31895935M", "OL31895933M", "OL45064422M", "OL35610498M", "OL30554852M", "OL40283062M", "OL39484618M", "OL45816018M", "OL45820521M", "OL38570439M", "OL40209188M", "OL44143514M", "OL43304516M", "OL43002626M", "OL42176164M", "OL42461513M", "OL42177146M", "OL39725653M", "OL42531109M", "OL39089246M", "OL46524689M", "OL40281142M", "OL40280942M", "OL39220846M", "OL37823892M", "OL38090979M", "OL37379733M", "OL37368387M", "OL37360847M", "OL37364615M", "OL36635392M", "OL35546010M", "OL35453787M", "OL35454906M", "OL35465544M", "OL35466909M", "OL35471759M", "OL35477338M", "OL7665576M", "OL8912642M", "OL22817523M", "OL20650379M", "OL19956072M", "OL17118975M", "OL25651813M", "OL7648114M", "OL16365545M", "OL19694682M", "OL17495884M", "OL7648645M", "OL12384993M", "OL7599494M", "OL7648286M", "OL7648263M", "OL8136359M", "OL7666385M", "OL24934354M", "OL12999131M", "OL12997838M", "OL9049311M", "OL9801507M", "OL27230665M", "OL27168034M", "OL13171358M", "OL12745752M", "OL26892898M", "OL32039515M", "OL25427321M", "OL26246389M", "OL26491472M", "OL9142140M", "OL26197337M", "OL16412769M", "OL13228036M", "OL28139349M", "OL26411714M", "OL26411716M", "OL9049233M", "OL9018013M", "OL9878602M", "OL8912590M", "OL21797154M", "OL9828124M", "OL31990745M", "OL27471738M", "OL8736247M", "OL8736086M", "OL8736085M", "OL8689657M", "OL8609820M", "OL31991683M", "OL31990397M", "OL29065077M", "OL28469428M", "OL28332460M", "OL8448754M", "OL11383513M", "OL11293098M", "OL7666520M", "OL7665639M", "OL22602505M", "OL20938720M", "OL7648934M", "OL11072438M", "OL7647492M", "OL11071412M", "OL7647205M", "OL9356317M", "OL7826042M", "OL2279888M", "OL2875365M", "OL27268659M", "OL26707048M", "OL27568111M", "OL25274057M", "OL27631135M", "OL24246927M", "OL29480770M", "OL28333110M", "OL31991742M", "OL29167637M", "OL24644006M", "OL9216745M", "OL9922139M", "OL22578749M", "OL16930518M", "OL9212707M", "OL14875713M", "OL4173672M", "OL20983474M", "OL26861200M", "OL6399517M", "OL21196019M", "OL16835133M", "OL20505182M", "OL23758375M", "OL4761892M", "OL20897622M", "OL22901761M", "OL26759991M", "OL25733376M", "OL32520886M", "OL39202625M", "OL39217528M", "OL39217498M", "OL32800860M", "OL8887141M", "OL23117018M", "OL23016493M", "OL32699972M", "OL11346274M", "OL9355644M", "OL32844359M", "OL22855183M", "OL9119837M", "OL7664724M", "OL7659405M", "OL32520899M", "OL27441124M", "OL20940337M", "OL26760307M", "OL7647774M", "OL11071785M", "OL3301827M", "OL26897042M", "OL27846256M"])
            ), Bookzzle.OLWorksDocs(
                key: "/works/OL17459210W",
                title: "And Then There Were None (adaptation)",
                firstPublishYear: Optional(2011),
                language: Optional(["eng"]),
                firstSentence: nil,
                numberOfPagesMedian: Optional(76),
                authorKey: Optional(["OL2802330A", "OL27695A"]),
                authorName: Optional(["Izabella Hearn", "Agatha Christie"]),
                coverI: Optional(11172294),
                coverEditionKey: Optional("OL26044162M"),
                ddc: nil,
                isbn: Optional(["9781408261200", "1408261200"]),
                lccn: nil,
                editionCount: Optional(1),
                editionKey: Optional(["OL26044162M"])
            ), Bookzzle.OLWorksDocs(
                key: "/works/OL20140045W",
                title: "And Then There Were None (adaptation)",
                firstPublishYear: Optional(1998),
                language: nil,
                firstSentence: nil,
                numberOfPagesMedian: Optional(64),
                authorKey: Optional(["OL1816052A", "OL27695A"]),
                authorName: Optional(["Peter Foreman", "Agatha Christie"]),
                coverI: nil,
                coverEditionKey: nil,
                ddc: nil,
                isbn: Optional(["9781899888221", "1899888225"]),
                lccn: nil,
                editionCount: Optional(1),
                editionKey: Optional(["OL27319914M"])
            ), Bookzzle.OLWorksDocs(
                key: "/works/OL24551413W",
                title: "And Then There Were None (graphic novel)",
                firstPublishYear: Optional(2020),
                language: nil,
                firstSentence: nil,
                numberOfPagesMedian: Optional(80),
                authorKey: Optional(["OL27695A", "OL8931928A", "OL9211640A"]),
                authorName: Optional(["Agatha Christie", "Callixte", "Pascal Davoz"]),
                coverI: Optional(11195264),
                coverEditionKey: Optional("OL32547743M"),
                ddc: nil,
                isbn: Optional(["2888909707", "9782888909705"]),
                lccn: nil,
                editionCount: Optional(1),
                editionKey: Optional(["OL32547743M"])
            ), Bookzzle.OLWorksDocs(
                key: "/works/OL23198854W",
                title: "And then there were none and selected plays",
                firstPublishYear: Optional(2014),
                language: Optional(["eng"]),
                firstSentence: nil,
                numberOfPagesMedian: Optional(575),
                authorKey: Optional(["OL27695A"]),
                authorName: Optional(["Agatha Christie"]),
                coverI: Optional(12855114),
                coverEditionKey: Optional("OL31032741M"),
                ddc: Optional(["822.914"]),
                isbn: Optional(["9781628992199", "1628992190"]),
                lccn: Optional(["2014026539"]),
                editionCount: Optional(1),
                editionKey: Optional(["OL31032741M"])
            ), Bookzzle.OLWorksDocs(key: "/works/OL472293W", title: "And Then There Were None [play]", firstPublishYear: Optional(1944), language: Optional(["eng"]), firstSentence: Optional(["IN THE CORNER of a first-class smoking carriage, Mr. Justice Wargrave, lately retired from the bench, puffed at a cigar and ran an interested eye through the political news in the Times."]), numberOfPagesMedian: Optional(95), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(8409844), coverEditionKey: nil, ddc: Optional(["822.912"]), isbn: Optional(["9781013420948", "9781013614859", "9780573014413", "0573616396", "9780573702310", "1013420942", "9780573616396", "0573014418", "0573702314", "9780062303240", "1013614852", "0062303244"]), lccn: Optional(["47002921", "46004014"]), editionCount: Optional(11), editionKey: Optional(["OL6511629M", "OL46183837M", "OL46209758M", "OL39805615M", "OL37400054M", "OL20073237M", "OL20714363M", "OL20372551M", "OL13985957M", "OL6497509M", "OL7859522M"])), Bookzzle.OLWorksDocs(key: "/works/OL27468428W", title: "And Then There Were None Teaching Guide", firstPublishYear: Optional(2017), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A", "OL9351373A"]), authorName: Optional(["Agatha Christie", "Amy Jurskis"]), coverI: nil, coverEditionKey: nil, ddc: nil, isbn: Optional(["9780062696267", "0062696262"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL37453754M"])), Bookzzle.OLWorksDocs(key: "/works/OL32479415W", title: "And Then There Were None (SparkNotes Literature Guide)", firstPublishYear: Optional(2014), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A", "OL8035840A"]), authorName: Optional(["Agatha Christie", "SparkNotes Staff"]), coverI: nil, coverEditionKey: nil, ddc: nil, isbn: Optional(["9781411472105", "1411472101"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL44266093M"])), Bookzzle.OLWorksDocs(key: "/works/OL27679055W", title: "And Then There Were None and other Classic Mysteries", firstPublishYear: Optional(2018), language: nil, firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(13254085), coverEditionKey: nil, ddc: nil, isbn: Optional(["9780062875914", "0062875914"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL37741976M"])), Bookzzle.OLWorksDocs(key: "/works/OL26570738W", title: "Secret Adversary and and Then There Were None Bundle", firstPublishYear: Optional(2020), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: nil, coverEditionKey: nil, ddc: nil, isbn: Optional(["0063036622", "9780063036628"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL35965901M"])), Bookzzle.OLWorksDocs(key: "/works/OL471974W", title: "Masterpieces of Murder (And Then There Were None / Death on the Nile / The Murder of Roger Ackroyd / Witness for the Prosecution)", firstPublishYear: Optional(1977), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: Optional(594), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(9265026), coverEditionKey: Optional("OL4900354M"), ddc: Optional(["823.912"]), isbn: Optional(["039607412X", "9780396074120"]), lccn: Optional(["76044421"]), editionCount: Optional(2), editionKey: Optional(["OL27909453M", "OL4900354M"])), Bookzzle.OLWorksDocs(key: "/works/OL20909839W", title: "Novels (And Then There Were None / N or M? / Secret Adversary / Towards Zero)", firstPublishYear: Optional(1992), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: nil, coverEditionKey: nil, ddc: nil, isbn: Optional(["0425135888", "9780425135884"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL10215920M"])), Bookzzle.OLWorksDocs(key: "/works/OL20983852W", title: "Novels (And Then There Were None / Murder of Roger Ackroyd / Murder on the Orient Express)", firstPublishYear: Optional(2015), language: nil, firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(10320656), coverEditionKey: nil, ddc: nil, isbn: Optional(["0008158614", "9780008158613"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL28421505M"])), Bookzzle.OLWorksDocs(key: "/works/OL472294W", title: "Novels (And Then There Were None / Pale Horse)", firstPublishYear: Optional(2002), language: Optional(["rus"]), firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: nil, coverEditionKey: nil, ddc: nil, isbn: Optional(["9785170006359", "5170006357"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL12536704M"])), Bookzzle.OLWorksDocs(key: "/works/OL40164684W", title: "Diez Negritos : (Ten Little Niggers or Ten Little Indians or and Then There Were None)", firstPublishYear: Optional(2016), language: Optional(["spa"]), firstSentence: nil, numberOfPagesMedian: Optional(156), authorKey: Optional(["OL27695A", "OL11220450A"]), authorName: Optional(["Agatha Christie", "Mate Editorial"]), coverI: nil, coverEditionKey: nil, ddc: nil, isbn: Optional(["1535131772", "9781535131773"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL54652995M"])), Bookzzle.OLWorksDocs(key: "/works/OL20908522W", title: "Novels (4.50 From Paddington / And Then There Were None)", firstPublishYear: Optional(1976), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: Optional(506), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(14591610), coverEditionKey: Optional("OL15570814M"), ddc: nil, isbn: nil, lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL15570814M"])), Bookzzle.OLWorksDocs(key: "/works/OL24710553W", title: "Oeuvres complètes d\'Agatha Christie - Volume VII (And Then There Were None / Cat Among Pigeons / Dumb Witness / Hickory Dickory Dock)", firstPublishYear: Optional(1988), language: Optional(["fre"]), firstSentence: nil, numberOfPagesMedian: Optional(664), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(11433335), coverEditionKey: Optional("OL32800702M"), ddc: nil, isbn: Optional(["9782702404836", "2702404839"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL32800702M"])), Bookzzle.OLWorksDocs(key: "/works/OL471650W", title: "Christie Classics (And Then There Were None / Murder of Roger Ackroyd / Philomel Cottge / Three Blind Mice / Witness for the Prosecution)", firstPublishYear: Optional(1954), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: Optional(410), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(9330159), coverEditionKey: Optional("OL27942233M"), ddc: Optional(["823.912"]), isbn: nil, lccn: Optional(["57007694"]), editionCount: Optional(2), editionKey: Optional(["OL22788840M", "OL27942233M"])), Bookzzle.OLWorksDocs(key: "/works/OL26236209W", title: "And Then There Were None; The Mystery of the Blue Train (graphic novel)", firstPublishYear: Optional(2011), language: nil, firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(12236125), coverEditionKey: Optional("OL35393555M"), ddc: nil, isbn: Optional(["6055443201", "9786055443207"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL35393555M"])), Bookzzle.OLWorksDocs(key: "/works/OL24261345W", title: "Novels (And Then There Were None / Crooked House / Murder on the Orient Express / Murder on the Links)", firstPublishYear: Optional(1996), language: Optional(["fre"]), firstSentence: nil, numberOfPagesMedian: Optional(750), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(10749332), coverEditionKey: nil, ddc: nil, isbn: Optional(["9782237000947", "2237000948"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL32094194M"])), Bookzzle.OLWorksDocs(key: "/works/OL35283687W", title: "Masterpieces of Murder (The Murder of Roger Ackroyd / And Then There Were None / Witness for the Prosecution / Death on the Nile)", firstPublishYear: Optional(1977), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: Optional(594), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(14586376), coverEditionKey: Optional("OL47695288M"), ddc: nil, isbn: nil, lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL47695288M"])), Bookzzle.OLWorksDocs(key: "/works/OL15331719W", title: "Novels (And Then There Were None / Murder of Roger Ackroyd / Murder on the Orient Express / Peril at End House)", firstPublishYear: Optional(1991), language: Optional(["rus"]), firstSentence: nil, numberOfPagesMedian: Optional(700), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(12294455), coverEditionKey: nil, ddc: nil, isbn: Optional(["5253002030", "9785253002032"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL22941854M"])), Bookzzle.OLWorksDocs(key: "/works/OL36777267W", title: "Journey into Fear / The 39 Steps / And Then There Were None / The Maltese Falcon / The Nine Tailors / The Doorbell Rang", firstPublishYear: Optional(1965), language: nil, firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL539397A", "OL18528A", "OL27695A", "OL28314A", "OL197515A", "OL22032A"]), authorName: Optional(["Eric Ambler", "John Buchan", "Agatha Christie", "Dashiell Hammett", "Dorothy L. Sayers", "Rex Stout"]), coverI: nil, coverEditionKey: nil, ddc: nil, isbn: nil, lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL49667447M"])), Bookzzle.OLWorksDocs(key: "/works/OL20912114W", title: "Crime Collection ( And Then There Were None / Dumb Witness / Mysterious Affair at Styles)", firstPublishYear: Optional(1970), language: nil, firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(12853496), coverEditionKey: nil, ddc: nil, isbn: Optional(["0600766101", "9780600766100"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL10919343M"])), Bookzzle.OLWorksDocs(key: "/works/OL471532W", title: "Novels (4.50 from Paddington / And Then There Were None / Death on the Nile  / Murder at the Vicarage / Secret Adversary / Secret of Chimneys)", firstPublishYear: Optional(2004), language: nil, firstSentence: nil, numberOfPagesMedian: nil, authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(2749960), coverEditionKey: Optional("OL11649687M"), ddc: nil, isbn: Optional(["1405047224", "9781405047227"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL11649687M"])), Bookzzle.OLWorksDocs(key: "/works/OL43242420W", title: "Journey into Fear, The 39 Steps, And Then There Were None, The Maltese Falcon, The Nine Tailors, and The Doorbell Rang (Great Mystery Books)", firstPublishYear: Optional(1965), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: Optional(194), authorKey: Optional(["OL13214434A"]), authorName: Optional(["Eric Ambler, John Buchan, Agatha Christie, Dashiell Hammett, Dorothy L. Sayers, Rex Stout"]), coverI: nil, coverEditionKey: nil, ddc: nil, isbn: nil, lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL58895371M"])), Bookzzle.OLWorksDocs(key: "/works/OL17306242W", title: "Works (And Then There Were None / Big Four / Mirror Crack\'d from Side to Side / Why didn\'t they ask Evans?)", firstPublishYear: Optional(2003), language: Optional(["rus"]), firstSentence: nil, numberOfPagesMedian: Optional(780), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(9265015), coverEditionKey: Optional("OL25879522M"), ddc: Optional(["823.912"]), isbn: Optional(["9785170143597", "5170143591"]), lccn: nil, editionCount: Optional(1), editionKey: Optional(["OL25879522M"])), Bookzzle.OLWorksDocs(key: "/works/OL471812W", title: "Five Complete Novels of Murder and Detection (And Then There Were None / Easy to Kill / Evil Under the Sun / Murder at Hazelmoor / Peril at End House)", firstPublishYear: Optional(1986), language: Optional(["eng"]), firstSentence: nil, numberOfPagesMedian: Optional(734), authorKey: Optional(["OL27695A"]), authorName: Optional(["Agatha Christie"]), coverI: Optional(9265011), coverEditionKey: Optional("OL2714871M"), ddc: Optional(["823.912"]), isbn: Optional(["0517037505", "9780517618233", "0517618230", "9780517037508"]), lccn: Optional(["86007861", "90026594"]), editionCount: Optional(4), editionKey: Optional(["OL7703569M", "OL2714871M", "OL50522429M", "OL1868279M"]))
        ]
    }
    
    // MARK: - UNWRAPPED AND FORMATTED MODEL OPTIONALS FOR VIEWS
    public var uFirstPublishYear: String {
        if let firstPublishYear { return String(firstPublishYear) } else { return "N/A" }
    }
    
    public var uLanguage: [String] {
        if let language { return language } else { return [] }
    }
    
    public var uFirstSentence: String {
        if let firstSentence { return firstSentence.first ?? "" } else { return "" }
    }
    
    public var uNumberOfPages: Int {
        if let numberOfPagesMedian { return numberOfPagesMedian } else { return 0 }
    }
    
    public var uAuthorKey: String {
        if let authorKey { return authorKey.first ?? "" } else { return "" }
    }
    
    public var uAuthorName: String {
        if let authorName { return authorName.joined(separator: ", ") } else { return "" }
    }
    
    public var uCoverI: Int {
        if let coverI { return coverI } else { return 0 }
    }
    
    public var uCoverEditionKey: String {
        if let coverEditionKey { return coverEditionKey } else { return "" }
    }
    
    public var uDDC: String {
        if let ddc { return ddc.first ?? "" } else { return "" }
    }
    
    public var uISBN: String {
        if let isbn { return isbn.first ?? "" } else { return "" }
    }
    
    public var uLCCN: String {
        if let lccn { return lccn.first ?? "" } else { return "" }
    }
    
    public var uEditionCount: Int {
        if let editionCount { return editionCount } else { return 0 }
    }
    
    public var uEditionKey: [String] {
        if let editionKey { return editionKey } else { return [] }
    }
}
