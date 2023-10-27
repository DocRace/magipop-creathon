import SwiftUI

struct TopicCardView: View {
    
    var imageName: String
    var name: String

    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(.vertical, 12)
            }
            Text(name).font(.title3).bold()
                .padding(.horizontal, 4)
                .padding(.bottom, 4)
        }
    }
}

struct FilterView: View {
    @State private var selection = 0
    let cards = [
        ["title": "the_legend_of_zelda_breath_of_the_wild", "name": "The Legend of Zelda: Breath of the Wild"],
        ["title": "red_dead_redemption_2", "name": "Red Dead Redemption 2"],
        ["title": "the_elder_scrolls_V", "name": "The Elder Scrolls V: Skyrim"],
        ["title": "super_mario_odyssey", "name": "Super Mario Odyssey"],
        ["title": "pokemon", "name": "Pokémon Sword Shield"],
        ["title": "animal_crossing", "name": "Animal Crossing"],
        ["title": "super_smash_bros", "name": "Super Smash Bros"]
        // Add your other cards here
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        GeometryReader { geometry in
                            Image("simon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .padding(.vertical, 12)
                            
                        }
                        Text("Simon Stalonhag").font(.title3).bold()
                            .padding(.horizontal, 4)
                            .padding(.bottom, 4)
                        Text("""
Simon Stålenhag is a renowned Swedish artist, author, and musician, best known for his unique blend of science fiction and rural Scandinavian landscapes. His highly imaginative art, which often features advanced technology juxtaposed against mundane, everyday settings, has won him international acclaim.

Stålenhag's works, primarily digital, are characterized by their attention to detail, realism, and ability to evoke nostalgia. His art often tells stories, inviting viewers into a post-apocalyptic or dystopian world filled with robots, dilapidated vehicles, and complex structures of unknown origin.

His narrative artbooks, including "Tales From the Loop" and "Things From the Flood," have been translated into multiple languages and have served as the inspiration for an Amazon Prime original series. As a musician, Stålenhag has also released albums of ambient music, further showcasing his versatility and creative prowess.

Whether through his mesmerizing artwork or his evocative storytelling, Simon Stålenhag continues to captivate audiences worldwide, offering a unique perspective on the intersection of humanity, nature, and technology.
""")
                        .padding(.horizontal, 4)
                        .padding(.bottom, 4)

                        Spacer()

                    }
                }
                
                Section {
                    ForEach(cards, id: \.self) { card in
                        TopicCardView(imageName: "title_\(card["title"]!)", name: card["name"]!)
                    }
                }
                
                Section {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Create new topic")
                    }
                    .font(.title3.bold())
                }
                
            }
            .navigationTitle("Filtering")
        }
    }
}
