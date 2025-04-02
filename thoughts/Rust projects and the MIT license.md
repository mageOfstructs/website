# Rust and the MIT license

- Note: This text was written by a silly dragon on the Internet without any legal knowledge.

I recently came across [this](https://www.youtube.com/watch?v=N2dbyFddcIs) Mental Outlaw video. It talks about an experiment of Canonical regarding the [oxidizr](https://github.com/jnsgruk/oxidizr) package. What that package essentially does is replace a bunch of system utilities with their *oxidized* Rust-equivalents.

Now, as a die-hard Rust-fan, I interpreted this as good news. Finally, our most used programs receive compiler-ensured memory/thread-safety! But besides being a bunch of Free-Software-Extremist propaganda, the rest of the video did mention a talking point I've never heard before: the license.

In case you don't know, Rust projects famously use the MIT license. Even *the Rust book itself* (appropriate page [here](https://doc.rust-lang.org/stable/book/ch14-02-publishing-to-crates-io.html)) sorta recommends it:

> Guidance on which license is appropriate for your project is beyond the scope of this book.
> Many people in the Rust community license their projects in the same way as Rust by using a dual license of MIT OR Apache-2.0.
> This practice demonstrates that you can also specify multiple license identifiers separated by OR to have multiple licenses for your project.

This is in stark contrast to the older C projects, which where born during the initial Free-Software-Movement and adapted some version of a copyleft license. What's the difference you ask? In short, a copyleft license, like the **GNU General Public License**, forbids anyone to use your project commercially (big asterisk goes here), whereas MIT does not. The most known example of this is probably MacOS, which is really just a proprietary fork of BSD, an MIT-licensed project. This is the main point I see FOSS-Extremists throw around when talking about these more permissive licenses. "*Oh, MIT takes away your freedom because companies can just fork and relicense [...]*" and so on.

So, with all the explaining out of the way, is this really a problem? Should you be concerned about Canonical making a proprietary version of coreutils? Probably not, though...I'm sure they'd try. But there's one point that is conveniently left out in this discussion:

I want to start this paragraph off with a quote from the Rust forums: `If licence-infringement, then BAD`. The GPL doesn't actually provide as much protection as you'd think it does ([example here](https://insrt.uk/post/andrew-tate-stealing-software-revolt)), since you can't expect your average FOSS dev to fight a whole legal battle just because of a license violation.

And that doesn't even mention the glaring loophole inside the license (talking about GPLv3 here) text, right here:

> Convey the object code by offering access from a designated place (gratis or for a charge), and offer equivalent access to the Corresponding Source in the same way through the same place at no further charge. You need not require recipients to copy the Corresponding Source along with the object code. If the place to copy the object code is a network server, the Corresponding Source may be on a different server (operated by you or a third party) that supports equivalent copying facilities, provided you maintain clear directions next to the object code saying where to find the Corresponding Source. Regardless of what server hosts the Corresponding Source, you remain obligated to ensure that it is available for as long as needed to satisfy these requirements.

What this means (to me) is that you *are* allowed to repackage and sell software, given that you provide *some* way of conveying the source. You could, for example, open an email account where people can send inquiries for it and then have it sent to them via CD. Worst is, you could even charge a fee for that!

Now, before you say "This doesn't apply to [insert other GNU license here]", I know, but GPLv3 is still the most common GNU license out there. Even the original coreutils uses it!

In the end, it's still the creator's choice what license to use and we should respect that. However, there is a discussion to be had about how a license affects the survival chances of a project, which should also be taken into consideration as the project grows. There *have* already been occurences of a company "stealing" an open-source project, regardless of the license used (it's just illegal in the case of copyleft ones). And even if it is illegal, it means nothing when no one is able/willing to step up and enforce the license's requirements. This is a problem greater than a simple license dilemma. A problem I do not have a solution to (mostly because all solutions I can think of require a lot of money). But who knows, maybe that won't be an issue when TFL's crypto investments suddenly skyrocket and they dedicate all their profits to fighting GPL violations. ;3
