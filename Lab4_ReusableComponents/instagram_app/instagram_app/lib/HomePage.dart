import 'package:flutter/material.dart';
import 'chat.dart';

class InstagramHomePage extends StatefulWidget {
  const InstagramHomePage({Key? key}) : super(key: key);

  @override
  State<InstagramHomePage> createState() => _InstagramHomePageState();
}

class _InstagramHomePageState extends State<InstagramHomePage> {
  late PageController _carouselController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = PageController();
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: _currentIndex == 0 ? _buildHomePage() : const ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF000000),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF737373),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Messages',
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        title: const Text(
          'Instagram',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Stories Section
              StorySection(),

              const SizedBox(height: 16),

              // Posts Section
              PostsSection(carouselController: _carouselController),
            ],
          ),
        ),
      ),
    );
  }
}

// Stories Section Widget
class StorySection extends StatelessWidget {
  final List<Map<String, String>> stories = [
    {'name': 'Your story', 'avatar': '', 'id': '0'},
    {'name': 'stigmalatyti', 'avatar': 'https://i.pravatar.cc/150?img=11', 'id': '1'},
    {'name': 'vicm12_', 'avatar': 'https://i.pravatar.cc/150?img=12', 'id': '2'},
    {'name': 'kayyiraa', 'avatar': 'https://i.pravatar.cc/150?img=13', 'id': '3'},
    {'name': 'bukanleslie', 'avatar': 'https://i.pravatar.cc/150?img=14', 'id': '4'},
    {'name': 'johndoe', 'avatar': 'https://i.pravatar.cc/150?img=15', 'id': '5'},
  ];

  StorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: index == 0
                        ? null
                        : const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFF58529),
                              Color(0xFFDD2A7B),
                              Color(0xFF8134AF),
                              Color(0xFF515BD4),
                            ],
                          ),
                    border: Border.all(
                      color: index == 0
                          ? const Color(0xFF262626)
                          : const Color(0xFFF58529),
                      width: 2,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1a1a1a),
                    ),
                    child: Center(
                      child: index == 0
                          ? const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 32,
                            )
                          : ClipOval(
                              child: Image.network(
                                stories[index]['avatar']!,
                                fit: BoxFit.cover,
                                width: 76,
                                height: 76,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[800],
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 80,
                  child: Text(
                    stories[index]['name']!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Posts Section Widget
class PostsSection extends StatelessWidget {
  final PageController carouselController;

  const PostsSection({Key? key, required this.carouselController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Post 1 - Carousel
        Post(
          username: 'bukanleslie',
          isCarousel: true,
          carouselController: carouselController,
          carouselImages: [
            'https://picsum.photos/400/400?random=1',
            'https://picsum.photos/400/400?random=2',
            'https://picsum.photos/400/400?random=3',
          ],
        ),
        const SizedBox(height: 8),

        // Post 2
        Post(
          username: 'vicm12_',
          isCarousel: false,
          postImage: 'https://picsum.photos/400/400?random=4',
          caption: 'City views 🌆',
        ),
        const SizedBox(height: 8),

        // Post 3
        Post(
          username: 'kayyiraa',
          isCarousel: false,
          postImage: 'https://picsum.photos/400/400?random=5',
          caption: 'Group photo 📸',
        ),
        const SizedBox(height: 8),

        // Post 4
        Post(
          username: 'stigmalatyti',
          isCarousel: false,
          postImage: 'https://picsum.photos/400/400?random=6',
          caption: 'Good times with friends',
        ),
        const SizedBox(height: 8),

        // Post 5
        Post(
          username: 'johndoe',
          isCarousel: false,
          postImage: 'https://picsum.photos/400/400?random=7',
          caption: 'Adventure awaits 🚀',
        ),
      ],
    );
  }
}

// Individual Post Widget
class Post extends StatefulWidget {
  final String username;
  final bool isCarousel;
  final String? caption;
  final String? postImage;
  final PageController? carouselController;
  final List<String>? carouselImages;

  const Post({
    Key? key,
    required this.username,
    required this.isCarousel,
    this.caption,
    this.postImage,
    this.carouselController,
    this.carouselImages,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isLiked = false;
  int likeCount = 234;
  int currentCarouselPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFF58529),
                      Color(0xFFDD2A7B),
                    ],
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1a1a1a),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://i.pravatar.cc/150?img=${widget.username.hashCode % 70}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '2 hours ago',
                      style: const TextStyle(
                        color: Color(0xFF737373),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ],
          ),
        ),

        // Post Image / Carousel
        if (widget.isCarousel)
          Stack(
            children: [
              SizedBox(
                height: 400,
                width: double.infinity,
                child: PageView.builder(
                  controller: widget.carouselController,
                  physics: const PageScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      currentCarouselPage = index;
                    });
                  },
                  itemCount: widget.carouselImages!.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      widget.carouselImages![index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[900],
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 80,
                              color: Colors.grey[800],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // Carousel Indicators (Dots)
              if (widget.carouselImages!.length > 1)
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.carouselImages!.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentCarouselPage == index
                              ? const Color(0xFF0095F6)
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )
        else
          Container(
            width: double.infinity,
            height: 400,
            color: Colors.grey[900],
            child: Image.network(
              widget.postImage ?? 'https://picsum.photos/400/400',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.image,
                    size: 80,
                    color: Colors.grey[800],
                  ),
                );
              },
            ),
          ),

        // Post Actions (Like, Comment, Share)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                    likeCount += isLiked ? 1 : -1;
                  });
                },
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        ),

        // Likes count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '$likeCount likes',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Caption
        if (widget.caption != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.username} ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: widget.caption!,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 12),

        // Comments preview
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'View all 42 comments',
            style: const TextStyle(
              color: Color(0xFF737373),
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
